//
//  BuildableTypeDeclSyntax.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax
import SwiftSyntaxBuilder

protocol BuildableTypeDeclSyntax: SyntaxProtocol {
    init(
        attributes: AttributeListSyntax,
        modifiers: DeclModifierListSyntax,
        name: TokenSyntax,
        inheritanceClause: InheritanceClauseSyntax,
        @MemberBlockItemListBuilder memberBlockBuilder: () throws -> MemberBlockItemListSyntax
      ) rethrows
}


extension ClassDeclSyntax: BuildableTypeDeclSyntax {
    @inlinable init(attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax, name: TokenSyntax, inheritanceClause: InheritanceClauseSyntax, memberBlockBuilder: () throws -> MemberBlockItemListSyntax) rethrows {
        try self.init(
            attributes: attributes,
            modifiers: modifiers,
            classKeyword: .keyword(.class),
            name: name,
            inheritanceClause: inheritanceClause,
            memberBlockBuilder: memberBlockBuilder
        )
    }
}

extension StructDeclSyntax: BuildableTypeDeclSyntax {
    @inlinable init(attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax, name: TokenSyntax, inheritanceClause: InheritanceClauseSyntax, memberBlockBuilder: () throws -> MemberBlockItemListSyntax) rethrows {
        try self.init(
            attributes: attributes,
            modifiers: modifiers,
            structKeyword: .keyword(.struct),
            name: name,
            inheritanceClause: inheritanceClause,
            memberBlockBuilder: memberBlockBuilder
        )
    }
}
