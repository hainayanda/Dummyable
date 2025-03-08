//
//  EnumDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct EnumDeclExtraction: TypeDeclExtraction {
    
    private let source: EnumDeclSyntax
    @inlinable var sourceDecl: TypeDeclSyntax { source }
    
    let choosenCase: EnumCaseElementSyntax
    
    @inlinable init(source: EnumDeclSyntax) throws {
        self.source = source
        let choosenCase = source.caseMarkedWithDummyableCaseAttr ?? source.easiestCase
        guard let choosenCase else {
            throw DummyableMacroError.enumCaseNotFound
        }
        self.choosenCase = choosenCase
    }
}

// MARK: DummyFuncForClosureDeclFactory + Extensions

extension DummyFuncForClosuresDeclFactory {
    @inlinable init(enumDecl: EnumDeclSyntax) throws {
        self.init(
            typeExtraction: try EnumDeclExtraction(source: enumDecl)
        )
    }
}

// MARK: DummyFuncUsingEnumCaseDeclFactory + Extensions

extension DummyFuncUsingEnumCaseDeclFactory {
    @inlinable init(enumDecl: EnumDeclSyntax) throws {
        let extraction = try EnumDeclExtraction(source: enumDecl)
        self.init(
            attributes: extraction.usableAttributes,
            modifiers: extraction.modifiers,
            genericParameters: extraction.genericParameters,
            returnType: IdentifierTypeSyntax(
                name: extraction.declName,
                genericArgumentClause: extraction.genericParameters?.asGenericArgumentClause
            ),
            genericWhereClause: extraction.genericWhereClause,
            enumCase: extraction.choosenCase
        )
    }
}
