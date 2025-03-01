//
//  DummyableInitMacro.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntax

struct DummyableInitMacro: PeerMacro {
    static func expansion(of node: AttributeSyntax, providingPeersOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard declaration.canBeAttachedWithDummyableInitMacro else {
            throw DummyableMacroError.attachedToInvalidType
        }
        return []
    }
}
