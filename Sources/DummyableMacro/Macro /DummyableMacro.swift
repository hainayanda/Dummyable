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
            DummyClosureFuncDeclFactory(protocolDecl: protocolDecl, node: node, closureType: .noArg),
            DummyClosureFuncDeclFactory(protocolDecl: protocolDecl, node: node, closureType: .oneArg),
            DummyClosureFuncDeclFactory(protocolDecl: protocolDecl, node: node, closureType: .twoArg),
            DummyClosureFuncDeclFactory(protocolDecl: protocolDecl, node: node, closureType: .threeArg),
            DummyClosureFuncDeclFactory(protocolDecl: protocolDecl, node: node, closureType: .fourArg)
        )
        .buildAllDecl()
    }
    
    private static func peerExpansion(of structDecl: StructDeclSyntax) throws -> [DeclSyntax] {
        try DeclBuildersAggregator(
            StructInitFuncPeerFactory(structDecl: structDecl),
            DummyClosureFuncDeclFactory(structDecl: structDecl, closureType: .noArg),
            DummyClosureFuncDeclFactory(structDecl: structDecl, closureType: .oneArg),
            DummyClosureFuncDeclFactory(structDecl: structDecl, closureType: .twoArg),
            DummyClosureFuncDeclFactory(structDecl: structDecl, closureType: .threeArg),
            DummyClosureFuncDeclFactory(structDecl: structDecl, closureType: .fourArg)
        )
        .buildAllDecl()
    }
    
    private static func peerExpansion(of classDecl: ClassDeclSyntax) throws -> [DeclSyntax] {
        try DeclBuildersAggregator(
            ClassInitFuncPeerFactory(classDecl: classDecl),
            DummyClosureFuncDeclFactory(classDecl: classDecl, closureType: .noArg),
            DummyClosureFuncDeclFactory(classDecl: classDecl, closureType: .oneArg),
            DummyClosureFuncDeclFactory(classDecl: classDecl, closureType: .twoArg),
            DummyClosureFuncDeclFactory(classDecl: classDecl, closureType: .threeArg),
            DummyClosureFuncDeclFactory(classDecl: classDecl, closureType: .fourArg)
        )
        .buildAllDecl()
    }
    
    private static func peerExpansion(of enumDecl: EnumDeclSyntax) throws -> [DeclSyntax] {
        try DeclBuildersAggregator(
            EnumMemberFuncPeerFactory(enumDecl: enumDecl),
            DummyClosureFuncDeclFactory(enumDecl: enumDecl, closureType: .noArg),
            DummyClosureFuncDeclFactory(enumDecl: enumDecl, closureType: .oneArg),
            DummyClosureFuncDeclFactory(enumDecl: enumDecl, closureType: .twoArg),
            DummyClosureFuncDeclFactory(enumDecl: enumDecl, closureType: .threeArg),
            DummyClosureFuncDeclFactory(enumDecl: enumDecl, closureType: .fourArg)
        )
        .buildAllDecl()
    }
}

