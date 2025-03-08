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
    
    @inlinable static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext) throws -> [DeclSyntax] {
            guard declaration.canBeAttachedWithDummyMacro else {
                throw DummyableMacroError.attachedToInvalidType(
                    attribute: "@Dummyable",
                    type: "protocol, struct, class or enum"
                )
            }
            guard let structDecl = declaration.as(StructDeclSyntax.self) else {
                return []
            }
            return try memberExpansion(of: structDecl)
        }
    
    private static func memberExpansion(of structDecl: StructDeclSyntax) throws -> [DeclSyntax] {
        try MemberwiseInitDeclFactory(structDecl: structDecl)?
            .buildDecls() ?? []
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
            ProtocolConcreteTypeDeclFactory(protocolDecl: protocolDecl, node: node),
            DummyFuncUsingInitDeclFactory(protocolDecl: protocolDecl, node: node),
            DummyFuncForClosuresDeclFactory(protocolDecl: protocolDecl, node: node)
        )
        .buildDecls()
    }
    
    private static func peerExpansion(of structDecl: StructDeclSyntax) throws -> [DeclSyntax] {
        try DeclBuildersAggregator(
            DummyFuncUsingInitDeclFactory(structDecl: structDecl),
            DummyFuncForClosuresDeclFactory(structDecl: structDecl)
        )
        .buildDecls()
    }
    
    private static func peerExpansion(of classDecl: ClassDeclSyntax) throws -> [DeclSyntax] {
        try DeclBuildersAggregator(
            DummyFuncUsingInitDeclFactory(classDecl: classDecl),
            DummyFuncForClosuresDeclFactory(classDecl: classDecl)
        )
        .buildDecls()
    }
    
    private static func peerExpansion(of enumDecl: EnumDeclSyntax) throws -> [DeclSyntax] {
        try DeclBuildersAggregator(
            DummyFuncUsingEnumCaseDeclFactory(enumDecl: enumDecl),
            DummyFuncForClosuresDeclFactory(enumDecl: enumDecl)
        )
        .buildDecls()
    }
}
