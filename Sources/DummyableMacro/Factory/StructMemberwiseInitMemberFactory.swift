//
//  StructMemberwiseInitMemberFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

struct StructMemberwiseInitMemberFactory: DeclBuilder {
    
    private let extraction: StructDeclExtraction
    private let memberwiseInitDeclFactory: DummyMemberwiseInitDeclFactory
    
    @inlinable var shouldGenerateInit: Bool { extraction.usableInitDecl == nil }
    
    @inlinable init(structDecl: StructDeclSyntax) {
        self.extraction = StructDeclExtraction(source: structDecl)
        self.memberwiseInitDeclFactory = DummyMemberwiseInitDeclFactory(
            modifiers: extraction.modifiers.noLessThanInternal(),
            parameters: extraction.variablesNeededForInit.asInitMemberwiseParam()
        )
    }
    
    @inlinable func buildDecl() -> DeclSyntax? {
        guard shouldGenerateInit else { return nil }
        return DeclSyntax(memberwiseInitDeclFactory.buildInitDecl())
    }
}
