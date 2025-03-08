//
//  TypeDeclSyntax.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

protocol TypeDeclSyntax {
    var attributes: AttributeListSyntax { get }
    var modifiers: DeclModifierListSyntax { get }
    var name: TokenSyntax { get }
    var genericParameterClause: GenericParameterClauseSyntax? { get }
    var genericWhereClause: GenericWhereClauseSyntax? { get }
    var memberBlock: MemberBlockSyntax { get }
}

extension StructDeclSyntax: TypeDeclSyntax {}
extension ClassDeclSyntax: TypeDeclSyntax {}
extension EnumDeclSyntax: TypeDeclSyntax {}
extension ProtocolDeclSyntax: TypeDeclSyntax {
    @inlinable var genericParameterClause: GenericParameterClauseSyntax? { nil }
}
