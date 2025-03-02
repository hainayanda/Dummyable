//
//  DummyableCaseMacro.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntax

struct DummyableCaseMacro: PeerMacro {
    @inlinable static func expansion(of node: AttributeSyntax, providingPeersOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard declaration.canBeAttachedWithDummyableCaseMacro else {
            throw DummyableMacroError.attachedToInvalidType(
                attribute: "@DummyableCase",
                type: "enumeration case"
            )
        }
        return []
    }
}
