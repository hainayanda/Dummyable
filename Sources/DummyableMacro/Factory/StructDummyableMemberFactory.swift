//
//  StructDummyableMemberFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

struct StructDummyableMemberFactory {
    
    let extraction: StructDeclExtraction
    let memberwiseInitDeclFactory: DummyMemberwiseInitDeclFactory
    
    var shouldGenerateInit: Bool { extraction.usableInitDecl == nil }
    
    init(extraction: StructDeclExtraction) {
        self.extraction = extraction
        self.memberwiseInitDeclFactory = DummyMemberwiseInitDeclFactory(
            modifiers: extraction.modifiers.noLessThanInternal(),
            parameters: extraction.variablesNeededForInit.asInitMemberwiseParam()
        )
    }
    
    func buildExtDecl() -> [DeclSyntax] {
        guard shouldGenerateInit else { return [] }
        return [
            DeclSyntax(
                memberwiseInitDeclFactory.buildInitDecl()
            )
        ]
    }
}

