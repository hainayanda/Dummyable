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
    static func expansion(of node: AttributeSyntax, providingPeersOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard declaration.canBeAttachedWithDummyableInitMacro else {
            throw DummyableMacroError.attachedToInvalidType
        }
        return []
    }
}
