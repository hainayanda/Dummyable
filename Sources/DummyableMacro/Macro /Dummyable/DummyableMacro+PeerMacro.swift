//
//  DummyableMacro+PeerMacro.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import Foundation
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntax

extension DummyableMacro: PeerMacro {
    
    static func expansion(of node: AttributeSyntax, providingPeersOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard declaration.canBeAttachedWithDummyMacro else {
            throw DummyableMacroError.attachedToInvalidType
        }
        if let protocolDecl = declaration.as(ProtocolDeclSyntax.self) {
            return try expansion(of: protocolDecl, node)
        } else {
            return []
        }
    }
    
    private static func expansion(of protocolDecl: ProtocolDeclSyntax, _ node: AttributeSyntax) throws -> [DeclSyntax] {
        try ProtocolDummyablePeerFactory(
            extraction: ProtocolDeclExtraction(source: protocolDecl, attribute: node)
        )
        .buildDecl()
        .inArray()
    }
}
