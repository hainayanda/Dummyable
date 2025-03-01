//
//  DummyableMacro+MemberMacro.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import Foundation
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntax

extension DummyableMacro: MemberMacro {
    
    static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard declaration.canBeAttachedWithDummyMacro else {
            throw DummyableMacroError.attachedToInvalidType(
                attribute: "@Dummyable",
                type: "protocol, struct, class or enum"
            )
        }
        if let structDecl = declaration.as(StructDeclSyntax.self) {
            return expansion(of: structDecl)
        } else {
            return []
        }
    }
    
    private static func expansion(of structDecl: StructDeclSyntax) -> [DeclSyntax] {
        return StructDummyableMemberFactory(
            extraction: StructDeclExtraction(source: structDecl)
        )
        .buildExtDecl()
    }
}
