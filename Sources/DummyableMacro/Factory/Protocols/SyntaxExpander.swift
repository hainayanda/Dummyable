//
//  DeclSyntaxExpander.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

protocol DeclSyntaxExpander {
    func expandDeclCodeGeneration() throws -> DeclSyntax
}

protocol ExtDeclSyntaxExpander {
    func expandExtensionCodeGeneration() throws -> ExtensionDeclSyntax
}
