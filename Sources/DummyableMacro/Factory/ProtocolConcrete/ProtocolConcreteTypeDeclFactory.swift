//
//  ProtocolConcreteTypeDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

struct ProtocolConcreteTypeDeclFactory: DeclBuilder, DummyFuncCallExprBuilder {
    
    private let extraction: ProtocolDeclExtraction
    
    @inlinable init(protocolDecl: ProtocolDeclSyntax, node: AttributeSyntax) {
        self.extraction = ProtocolDeclExtraction(source: protocolDecl, attribute: node)
    }
    
    @inlinable func buildDecl() throws -> DeclSyntax? {
        return switch try extraction.generationType {
        case .class:
            try DeclSyntax(
                buildTypeDecl(
                    ClassDeclSyntax.self,
                    modifiers: [.final, .private]
                )
            )
        case .struct:
            try DeclSyntax(
                buildTypeDecl(
                    StructDeclSyntax.self,
                    modifiers: [.private]
                )
            )
        }
    }
    
    private func buildTypeDecl<T: BuildableTypeDeclSyntax>(
        _ type: T.Type,
        modifiers: DeclModifierListSyntax) throws -> T {
            try T(
                attributes: extraction.usableAttributes,
                modifiers: modifiers,
                name: extraction.generationName,
                inheritanceClause: buildInherintanceClause()
            ) {
                for variable in extraction.variablesNeededForInit {
                    try buildVariableDecl(from: variable)
                }
                for initializer in extraction.mandatoryInits {
                    buildMandatoryInit(from: initializer)
                }
                for function in extraction.mandatoryFunctions {
                    buildFuncDecl(from: function)
                }
            }
        }
    
    private func buildInherintanceClause() -> InheritanceClauseSyntax {
        InheritanceClauseSyntax(
            inheritedTypes: InheritedTypeListSyntax {
                InheritedTypeSyntax(
                    type: IdentifierTypeSyntax(name: extraction.declName)
                )
            }
        )
    }
    
    private func buildVariableDecl(from variable: VariableDeclSyntax) throws -> VariableDeclSyntax {
        try ProtocolConcreteVariableDeclFactory(
            modifiers: extraction.modifiers.noLessThanInternal(),
            baseVariable: variable
        )
        .buildVariableDecl()
    }
    
    private func buildMandatoryInit(from initializer: InitializerDeclSyntax) -> InitializerDeclSyntax {
        ProtocolConcreteInitDeclFactory(
            modifiers: extraction.modifiers.noLessThanInternal(),
            baseInit: initializer,
            mandatoryVariables: extraction.variablesNeededForInit.extracts()
        )
        .buildInitDecl()
    }
    
    private func buildFuncDecl(from function: FunctionDeclSyntax) -> FunctionDeclSyntax {
        ProtocolConcreteFuncDeclFactory(
            modifiers: extraction.modifiers.noLessThanInternal(),
            baseFunc: function
        )
        .buildFuncDecl()
    }
}
