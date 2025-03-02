//
//  DeclBuilder.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

protocol DeclBuilder {
    func buildDecl() throws -> DeclSyntax?
}
