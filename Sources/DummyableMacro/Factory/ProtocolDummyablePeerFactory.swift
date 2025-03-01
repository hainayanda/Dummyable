//
//  DummyOnProtocolTypeDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

struct ProtocolDummyablePeerFactory: DummyFuncCallCodeBuilder {
    
    let extraction: ProtocolDeclExtraction
    
    init(extraction: ProtocolDeclExtraction) {
        self.extraction = extraction
    }
    
    func buildDecl() throws -> DeclSyntax {
        return switch try extraction.generationType {
        case .class:
            try DeclSyntax(buildClassDecl())
        case .struct:
            try DeclSyntax(buildStructDecl())
        }
    }
    
    private func buildStructDecl() throws -> StructDeclSyntax {
        try StructDeclSyntax(
            attributes: extraction.usableAttributes,
            modifiers: [.private],
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
    
    private func buildClassDecl() throws -> ClassDeclSyntax {
        try ClassDeclSyntax(
            attributes: extraction.usableAttributes,
            modifiers: [.final, .private],
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
        try DummyVariableFromProtocolDeclFactory(
            modifiers: extraction.modifiers.noLessThanInternal(),
            baseVariable: variable
        )
        .buildVariableDecl()
    }
    
    private func buildMandatoryInit(from initializer: InitializerDeclSyntax) -> InitializerDeclSyntax {
        DummyInitFromProtocolDeclFactory(
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


