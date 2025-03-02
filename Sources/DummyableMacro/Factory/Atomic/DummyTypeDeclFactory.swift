//
//  DummyTypeDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummyTypeDeclFactory<Syntax: BuildableTypeDeclSyntax>: DeclBuilder {
    
    let modifiers: DeclModifierListSyntax
    let extraction: ProtocolDeclExtraction
    
    // periphery:ignore:parameters type
    @inlinable init(modifiers: DeclModifierListSyntax, extraction: ProtocolDeclExtraction, for type: Syntax.Type) {
        self.modifiers = modifiers
        self.extraction = extraction
    }
    
    @inlinable func buildDecl() throws -> DeclSyntax? {
        try DeclSyntax(buildTypeDecl())
    }
    
    private func buildTypeDecl() throws -> Syntax {
        try Syntax(
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
        try DummyProtocolVariableDeclFactory(
            modifiers: extraction.modifiers.noLessThanInternal(),
            baseVariable: variable
        )
        .buildVariableDecl()
    }
    
    private func buildMandatoryInit(from initializer: InitializerDeclSyntax) -> InitializerDeclSyntax {
        DummyProtocolInitDeclFactory(
            modifiers: extraction.modifiers.noLessThanInternal(),
            baseInit: initializer,
            mandatoryVariables: extraction.variablesNeededForInit.extracts()
        )
        .buildInitDecl()
    }
    
    private func buildFuncDecl(from function: FunctionDeclSyntax) -> FunctionDeclSyntax {
        DummyFuncFromProtocolDeclFactory(
            modifiers: extraction.modifiers.noLessThanInternal(),
            baseFunc: function
        )
        .buildFuncDecl()
    }
}
