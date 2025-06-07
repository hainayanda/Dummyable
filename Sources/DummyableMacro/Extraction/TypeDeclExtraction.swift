//
//  TypeDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

protocol TypeDeclExtraction {
    var sourceDecl: TypeDeclSyntax { get }
    var usableAttributes: AttributeListSyntax { get }
    var modifiers: DeclModifierListSyntax { get }
    var declName: TokenSyntax { get }
    var genericParameters: GenericParameterListSyntax? { get }
    var genericWhereClause: GenericWhereClauseSyntax? { get }
    var usableInitDecl: InitializerDeclSyntax? { get }
}

extension TypeDeclExtraction {
    
    @inlinable var usableAttributes: AttributeListSyntax {
        AttributeListSyntax(
            sourceDecl.attributes
                .compactMap { $0.as(AttributeSyntax.self) }
                .filter { $0.is(.available) }
                .map { .attribute($0).trimmed }
        )
    }
    
    @inlinable var modifiers: DeclModifierListSyntax {
        sourceDecl.modifiers.trimmed
    }
    
    @inlinable var declName: TokenSyntax {
        sourceDecl.name.trimmed
    }
    
    @inlinable var genericParameters: GenericParameterListSyntax? {
        sourceDecl.genericParameterClause?.parameters.trimmed
    }
    
    @inlinable var genericWhereClause: GenericWhereClauseSyntax? {
        sourceDecl.genericWhereClause?.trimmed
    }
    
    @inlinable var usableInitDecl: InitializerDeclSyntax? {
        nil
    }
}

// MARK: DummyInitFuncDeclFactory + Extensions

extension DummyFuncUsingInitDeclFactory {
    @inlinable init(typeExtraction: TypeDeclExtraction) {
        self.init(
            attributes: typeExtraction.usableAttributes,
            modifiers: typeExtraction.modifiers,
            genericParameters: typeExtraction.genericParameters,
            returnType: IdentifierTypeSyntax(
                name: typeExtraction.declName,
                genericArgumentClause: typeExtraction.genericParameters?.asGenericArgumentClause
            ),
            genericWhereClause: typeExtraction.genericWhereClause,
            initType: DeclReferenceExprSyntax(baseName: typeExtraction.declName),
            dummyInitializerParameters: typeExtraction.usableInitDecl?.asInitializerParameters() ?? []
        )
    }
}



// MARK: DummyFuncForClosureDeclFactory + Extensions

extension DummyFuncForClosuresDeclFactory {
    @inlinable init(
        typeExtraction: TypeDeclExtraction,
        creationType: DummyCreationType = .dummyFuncCall) {
            self.init(
                attributes: typeExtraction.usableAttributes,
                modifiers: typeExtraction.modifiers.onlyAccessModifier(),
                genericParameters: typeExtraction.genericParameters,
                returnType: IdentifierTypeSyntax(
                    name: typeExtraction.declName,
                    genericArgumentClause: typeExtraction.genericParameters?.asGenericArgumentClause
                ),
                genericWhereClause: typeExtraction.genericWhereClause,
                creationType: creationType
            )
        }
    
    @inlinable init(
        protocolExtraction: ProtocolDeclExtraction,
        creationType: DummyCreationType = .dummyFuncCall) {
            self.init(
                attributes: protocolExtraction.usableAttributes,
                modifiers: protocolExtraction.modifiers.onlyAccessModifier(),
                genericParameters: protocolExtraction.genericParameters,
                returnType: SomeOrAnyTypeSyntax(
                    someOrAnySpecifier: .keyword(.any),
                    constraint: IdentifierTypeSyntax(
                        name: protocolExtraction.declName
                    )
                ),
                genericWhereClause: protocolExtraction.genericWhereClause,
                creationType: creationType
            )
        }
}

// MARK: DummiesFuncDeclFactory + Extensions

extension DummyFuncForArrayDeclFactory {
    @inlinable init(
        typeExtraction: TypeDeclExtraction,
        creationType: DummyCreationType = .dummyFuncCall) {
            self.init(
                attributes: typeExtraction.usableAttributes,
                modifiers: typeExtraction.modifiers.onlyAccessModifier(),
                genericParameters: typeExtraction.genericParameters,
                elementType: IdentifierTypeSyntax(
                    name: typeExtraction.declName,
                    genericArgumentClause: typeExtraction.genericParameters?.asGenericArgumentClause
                ),
                genericWhereClause: typeExtraction.genericWhereClause,
                creationType: creationType
            )
        }
    
    @inlinable init(
        protocolExtraction: ProtocolDeclExtraction,
        creationType: DummyCreationType = .dummyFuncCall) {
            self.init(
                attributes: protocolExtraction.usableAttributes,
                modifiers: protocolExtraction.modifiers.onlyAccessModifier(),
                genericParameters: protocolExtraction.genericParameters,
                elementType: SomeOrAnyTypeSyntax(
                    someOrAnySpecifier: .keyword(.any),
                    constraint: IdentifierTypeSyntax(
                        name: protocolExtraction.declName
                    )
                ),
                genericWhereClause: protocolExtraction.genericWhereClause,
                creationType: creationType
            )
        }
}
