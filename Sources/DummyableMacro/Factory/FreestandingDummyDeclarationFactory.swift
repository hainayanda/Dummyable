//
//  FreestandingDummyDeclarationFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct FreestandingDummyDeclarationFactory: DeclBuilder {
    let extraction: FreestandingMacroExtraction
    let dummyFuncDeclFactory: DummyFuncDeclFactory
    
    @inlinable init(use freestanding: FreestandingMacroExpansionSyntax) throws {
        self.extraction = try FreestandingMacroExtraction(from: freestanding)
        self.dummyFuncDeclFactory = DummyFuncDeclFactory(
            attributes: [],
            modifiers: extraction.modifiers,
            returnType: IdentifierTypeSyntax(name: extraction.type.baseName)
        )
    }
    
    @inlinable func buildDecl() throws -> DeclSyntax? {
        DeclSyntax(
            dummyFuncDeclFactory.buildDummyFuncDecl {
                extraction.closure.statements.trimmed
            }
        )
    }
}
