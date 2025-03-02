//
//  TypeDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

protocol TypeDeclExtraction {
    var sourceDecl: TypeDeclSyntax { get }
    var declName: TokenSyntax { get }
    var usableAttributes: AttributeListSyntax { get }
    var modifiers: DeclModifierListSyntax { get }
    var usableInitDecl: InitializerDeclSyntax? { get }
}

extension TypeDeclExtraction {
    @inlinable var declName: TokenSyntax {
        sourceDecl.name.trimmed
    }
    
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
    
    @inlinable var usableInitDecl: InitializerDeclSyntax? {
        nil
    }
}

// MARK: DummyInitFuncDeclFactory + Extensions

extension DummyInitFuncDeclFactory {
    @inlinable init(typeExtraction: TypeDeclExtraction) {
        self.init(
            attributes: typeExtraction.usableAttributes,
            modifiers: typeExtraction.modifiers,
            returnType: IdentifierTypeSyntax(name: typeExtraction.declName),
            initType: DeclReferenceExprSyntax(baseName: typeExtraction.declName),
            dummyInitializerParameters: typeExtraction.usableInitDecl?.asInitializerParameters() ?? []
        )
    }
}

// MARK: DummyClosureFuncDeclFactory + Extensions

extension DummyClosureFuncDeclFactory {
    init(typeExtraction: TypeDeclExtraction, closureType: DummyClosureFuncDeclFactory.ClosureType, creationType: DummyClosureFuncDeclFactory.ClosureTypeCreation = .dummyFuncCall) {
        self.init(
            closureType: closureType,
            attributes: typeExtraction.usableAttributes,
            modifiers: typeExtraction.modifiers.onlyAccessModifier(),
            returnType: IdentifierTypeSyntax(name: typeExtraction.declName),
            creationType: creationType
        )
    }
}
