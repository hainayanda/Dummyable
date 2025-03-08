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
        let extraction = StructDeclExtraction(source: structDecl)
        return try MemberwiseInitDeclFactory(extraction: extraction)?
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
        let extraction = ProtocolDeclExtraction(source: protocolDecl, attribute: node)
        return try DeclBuildersAggregator(
            ProtocolConcreteTypeDeclFactory(extraction: extraction),
            DummyFuncUsingInitDeclFactory(protocolExtraction: extraction),
            DummyFuncForArrayDeclFactory(protocolExtraction: extraction),
            DummyFuncForClosuresDeclFactory(protocolExtraction: extraction)
        )
        .buildDecls()
    }
    
    private static func peerExpansion(of structDecl: StructDeclSyntax) throws -> [DeclSyntax] {
        let extraction = StructDeclExtraction(source: structDecl)
        return try DeclBuildersAggregator(
            DummyFuncUsingInitDeclFactory(typeExtraction: extraction),
            DummyFuncForArrayDeclFactory(typeExtraction: extraction),
            DummyFuncForClosuresDeclFactory(typeExtraction: extraction)
        )
        .buildDecls()
    }
    
    private static func peerExpansion(of classDecl: ClassDeclSyntax) throws -> [DeclSyntax] {
        let extraction = try ClassDeclExtraction(source: classDecl)
        return try DeclBuildersAggregator(
            DummyFuncUsingInitDeclFactory(typeExtraction: extraction),
            DummyFuncForArrayDeclFactory(typeExtraction: extraction),
            DummyFuncForClosuresDeclFactory(typeExtraction: extraction)
        )
        .buildDecls()
    }
    
    private static func peerExpansion(of enumDecl: EnumDeclSyntax) throws -> [DeclSyntax] {
        let extraction = try EnumDeclExtraction(source: enumDecl)
        return try DeclBuildersAggregator(
            DummyFuncUsingEnumCaseDeclFactory(extraction: extraction),
            DummyFuncForArrayDeclFactory(typeExtraction: extraction),
            DummyFuncForClosuresDeclFactory(typeExtraction: extraction)
        )
        .buildDecls()
    }
}
