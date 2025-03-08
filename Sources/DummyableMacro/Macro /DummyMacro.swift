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
    @inlinable static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext) throws -> [DeclSyntax] {
            try DeclBuildersAggregator(
                FreestandingDummyDeclarationFactory(use: node),
                DummyFuncForClosuresDeclFactory(node: node)
            )
            .buildDecls()
        }
}
