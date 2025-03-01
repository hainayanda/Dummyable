//
//  DummyMacro.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import Foundation
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntax

struct DummyMacro: DeclarationMacro {
    static func expansion(of node: some FreestandingMacroExpansionSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        try FreestandingDummyDeclarationFactory(
            extraction: try FreestandingMacroExtraction(from: node)
        )
        .buildDecl()
    }
}
