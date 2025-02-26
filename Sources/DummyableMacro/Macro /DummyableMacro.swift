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

struct DummyableMacro: PeerMacro {
    static func expansion(of node: AttributeSyntax, providingPeersOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard declaration.canBeAttachedWithDummyMacro else {
            throw DummyableMacroError.attachedToInvalidType
        }
        if let protocolDecl = declaration.as(ProtocolDeclSyntax.self) {
            let extraction = ProtocolDeclExtraction(source: protocolDecl, attribute: node)
            return try DummyOnProtocolDeclMacroFactory(extraction: extraction)
                .expandDeclCodeGeneration()
                .inArray()
        } else {
            return []
        }
    }
}

extension DummyableMacro: ExtensionMacro {
    static func expansion(of node: AttributeSyntax, attachedTo declaration: some DeclGroupSyntax, providingExtensionsOf type: some TypeSyntaxProtocol, conformingTo protocols: [TypeSyntax], in context: some MacroExpansionContext) throws -> [ExtensionDeclSyntax] {
        guard declaration.canBeAttachedWithDummyMacro else {
            throw DummyableMacroError.attachedToInvalidType
        }
        if let protocolDecl = declaration.as(ProtocolDeclSyntax.self) {
            let extraction = ProtocolDeclExtraction(source: protocolDecl, attribute: node)
            return try DummyOnProtocolFuncDeclMacroFactory(extraction: extraction)
                .expandExtensionCodeGeneration()
                .inArray()
        } else if let classDecl = declaration.as(ClassDeclSyntax.self) {
            return []
        } else if let structDecl = declaration.as(StructDeclSyntax.self) {
            let extraction = StructDeclExtraction(source: structDecl, attribute: node)
            return try DummyOnStructExtDeclMacroFactory(extraction: extraction)
                .expandExtensionCodeGeneration()
                .inArray()
        } else if let enumDecl = declaration.as(EnumDeclSyntax.self) {
            return []
        } else {
            return []
        }
    }
}
