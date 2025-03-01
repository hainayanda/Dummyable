//
//  DummyableMacro+ExtensionMacro.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import Foundation
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntax

extension DummyableMacro: ExtensionMacro {
    
    static func expansion(of node: AttributeSyntax, attachedTo declaration: some DeclGroupSyntax, providingExtensionsOf type: some TypeSyntaxProtocol, conformingTo protocols: [TypeSyntax], in context: some MacroExpansionContext) throws -> [ExtensionDeclSyntax] {
        guard declaration.canBeAttachedWithDummyMacro else {
            throw DummyableMacroError.attachedToInvalidType
        }
        if let protocolDecl = declaration.as(ProtocolDeclSyntax.self) {
            return expansion(of: protocolDecl, node)
        } else if let classDecl = declaration.as(ClassDeclSyntax.self) {
            return try expansion(of: classDecl)
        } else if let structDecl = declaration.as(StructDeclSyntax.self) {
            return expansion(of: structDecl)
        } else if let enumDecl = declaration.as(EnumDeclSyntax.self) {
            return []
        } else {
            return []
        }
    }
    
    private static func expansion(of protocolDecl: ProtocolDeclSyntax, _ node: AttributeSyntax) -> [ExtensionDeclSyntax] {
        return DummyableOnProtocolDummiesFuncDeclFactory(
            extraction: ProtocolDeclExtraction(source: protocolDecl, attribute: node)
        )
        .buildExtDecl()
        .inArray()
    }
    
    private static func expansion(of structDecl: StructDeclSyntax) -> [ExtensionDeclSyntax] {
        return DummyOnStructFuncDeclMacroFactory(
            extraction: StructDeclExtraction(source: structDecl)
        )
        .expandExtensionCodeGeneration()
        .inArray()
    }
    
    private static func expansion(of classDecl: ClassDeclSyntax) throws -> [ExtensionDeclSyntax] {
        return try DummyOnClassFuncDeclMacroFactory(
            extraction: ClassDeclExtraction(source: classDecl)
        )
        .expandExtensionCodeGeneration()
        .inArray()
    }
}
