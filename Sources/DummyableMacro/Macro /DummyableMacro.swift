//
//  DummyableMacro.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import Foundation
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntax

struct DummyableMacro { }

extension DummyableMacro: MemberMacro {
    
    @inlinable static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard declaration.canBeAttachedWithDummyMacro else {
            throw DummyableMacroError.attachedToInvalidType(
                attribute: "@Dummyable",
                type: "protocol, struct, class or enum"
            )
        }
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            return []
        }
        return memberExpansion(of: structDecl)
    }
    
    private static func memberExpansion(of structDecl: StructDeclSyntax) -> [DeclSyntax] {
        StructMemberwiseInitMemberFactory(structDecl: structDecl)
            .buildDecl()
            .inArray()
    }
}

extension DummyableMacro: PeerMacro {
    
    @inlinable static func expansion(of node: AttributeSyntax, providingPeersOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        if let protocolDecl = declaration.as(ProtocolDeclSyntax.self) {
            return try peerExpansion(of: protocolDecl, node)
        } else if let classDecl = declaration.as(ClassDeclSyntax.self) {
            return try peerExpansion(of: classDecl)
        } else if let structDecl = declaration.as(StructDeclSyntax.self) {
            return peerExpansion(of: structDecl)
        } else if let enumDecl = declaration.as(EnumDeclSyntax.self) {
            return try peerExpansion(of: enumDecl)
        } else {
            throw DummyableMacroError.attachedToInvalidType(
                attribute: "@Dummyable",
                type: "protocol, struct, class or enum"
            )
        }
    }
    
    private static func peerExpansion(of protocolDecl: ProtocolDeclSyntax, _ node: AttributeSyntax) throws -> [DeclSyntax] {
        try DeclBuildersAggregator(
            ProtocolDummyTypeDeclPeerFactory(protocolDecl: protocolDecl, node: node),
            ProtocolDummyFuncDeclPeerFactory(protocolDecl: protocolDecl, node: node)
        )
        .buildAllDecl()
    }
    
    private static func peerExpansion(of structDecl: StructDeclSyntax) -> [DeclSyntax] {
        StructInitFuncPeerFactory(structDecl: structDecl)
            .buildDecl()
            .inArray()
    }
    
    private static func peerExpansion(of classDecl: ClassDeclSyntax) throws -> [DeclSyntax] {
        try ClassInitFuncPeerFactory(classDecl: classDecl)
            .buildDecl()
            .inArray()
    }
    
    private static func peerExpansion(of enumDecl: EnumDeclSyntax) throws -> [DeclSyntax] {
        try EnumMemberFuncPeerFactory(enumDecl: enumDecl)
            .buildDecl()
            .inArray()
    }
}

