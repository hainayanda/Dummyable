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
    var declName: TokenSyntax {
        sourceDecl.name.trimmed
    }
    
    var usableAttributes: AttributeListSyntax {
        AttributeListSyntax(
            sourceDecl.attributes
                .compactMap { $0.as(AttributeSyntax.self) }
                .filter { $0.is(.available) }
                .map { .attribute($0).trimmed }
        )
    }
}
