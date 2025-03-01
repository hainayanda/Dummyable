//
//  TypeDeclSyntax.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

protocol TypeDeclSyntax {
    var name: TokenSyntax { get }
    var attributes: AttributeListSyntax { get }
}

extension StructDeclSyntax: TypeDeclSyntax {}
extension ClassDeclSyntax: TypeDeclSyntax {}
