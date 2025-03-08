//
//  FreestandingDummyDeclarationFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct FreestandingDummyDeclarationFactory: DeclBuilder {
    private let extraction: FreestandingMacroExtraction
    private let dummyFuncDeclFactory: DummyFuncDeclFactory
    
    @inlinable init(use freestanding: FreestandingMacroExpansionSyntax) throws {
        self.extraction = try FreestandingMacroExtraction(from: freestanding)
        self.dummyFuncDeclFactory = DummyFuncDeclFactory(
            attributes: extraction.metaDatas.attributes ?? [],
            modifiers: extraction.modifiers,
            genericParametersClause: extraction.metaDatas.genericParametersClause,
            returnType: extraction.type,
            genericWhereClause: extraction.metaDatas.genericWhereClauses
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
