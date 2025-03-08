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
        return if let protocolDecl = declaration.as(ProtocolDeclSyntax.self) {
            try peerExpansion(of: protocolDecl, node)
        } else if let classDecl = declaration.as(ClassDeclSyntax.self) {
            try peerExpansion(of: classDecl)
        } else if let structDecl = declaration.as(StructDeclSyntax.self) {
            try peerExpansion(of: structDecl)
        } else if let enumDecl = declaration.as(EnumDeclSyntax.self) {
            try peerExpansion(of: enumDecl)
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
            ProtocolDummyFuncDeclPeerFactory(protocolDecl: protocolDecl, node: node),
            DummyClosuresFuncDeclFactory(protocolDecl: protocolDecl, node: node)
        )
        .buildDecls()
    }
    
    private static func peerExpansion(of structDecl: StructDeclSyntax) throws -> [DeclSyntax] {
        try DeclBuildersAggregator(
            StructInitFuncPeerFactory(structDecl: structDecl),
            DummyClosuresFuncDeclFactory(structDecl: structDecl)
        )
        .buildDecls()
    }
    
    private static func peerExpansion(of classDecl: ClassDeclSyntax) throws -> [DeclSyntax] {
        try DeclBuildersAggregator(
            ClassInitFuncPeerFactory(classDecl: classDecl),
            DummyClosuresFuncDeclFactory(classDecl: classDecl)
        )
        .buildDecls()
    }
    
    private static func peerExpansion(of enumDecl: EnumDeclSyntax) throws -> [DeclSyntax] {
        try DeclBuildersAggregator(
            EnumMemberFuncPeerFactory(enumDecl: enumDecl),
            DummyClosuresFuncDeclFactory(enumDecl: enumDecl)
        )
        .buildDecls()
    }
}

