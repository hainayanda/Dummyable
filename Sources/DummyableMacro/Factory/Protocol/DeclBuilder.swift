//
//  DeclBuilder.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

protocol DeclBuilder: ArrayDeclBuilder {
    func buildDecl() throws -> DeclSyntax?
}

extension DeclBuilder {
    @inlinable func buildDecls() throws -> [DeclSyntax] {
        guard let decl = try buildDecl() else {
            return []
        }
        return decl.inArray()
    }
}

protocol ArrayDeclBuilder {
    func buildDecls() throws -> [DeclSyntax]
}
