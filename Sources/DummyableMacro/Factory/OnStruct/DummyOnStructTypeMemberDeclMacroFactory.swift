//
//  DummyOnStructTypeMemberDeclMacroFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

struct DummyOnStructTypeMemberDeclMacroFactory {
    
    let extraction: StructDeclExtraction
    let initDeclFactory: DummyInitDeclFactory
    
    var shouldGenerateInit: Bool { extraction.usableInitDecl == nil }
    
    init(extraction: StructDeclExtraction) {
        self.extraction = extraction
        self.initDeclFactory = DummyInitDeclFactory(
            modifiers: extraction.modifiers.noLessThanInternal(),
            parameters: extraction.variablesNeededForInit.asInitializerDirectParameters()
        )
    }
    
    func expandDeclCodeGeneration() -> DeclSyntax? {
        guard shouldGenerateInit else { return nil }
        return DeclSyntax(
            initDeclFactory.buildInitDecl()
        )
    }
}

