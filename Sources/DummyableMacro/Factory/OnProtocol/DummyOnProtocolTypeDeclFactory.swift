//
//  DummyOnProtocolTypeDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

struct DummyOnProtocolTypeDeclFactory: DummyFuncCallCodeBuilder {
    
    let extraction: ProtocolDeclExtraction
    let initDeclFactory: DummyInitDeclFactory
    
    init(extraction: ProtocolDeclExtraction) {
        self.extraction = extraction
        self.initDeclFactory = DummyInitDeclFactory(
            modifiers: extraction.modifiers.noLessThanInternal(),
            parameters: extraction.variablesNeededForInit.asInitializerDirectParameters()
        )
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
            initDeclFactory.buildInitDecl()
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
            initDeclFactory.buildInitDecl()
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
        guard let variableExtraction = variable.extraction else {
            throw DummyableMacroError.failToGenerateMacro
        }
        var variable = variable
        variable.modifiers = extraction.modifiers.noLessThanInternal()
        variable.bindings = PatternBindingListSyntax {
            PatternBindingSyntax(
                pattern: variableExtraction.name,
                typeAnnotation: variableExtraction.typeAnotation
            )
        }
        return variable
    }
    
    private func buildFuncDecl(from function: FunctionDeclSyntax) -> FunctionDeclSyntax {
        var function = function
        function.attributes = extraction.usableAttributes
        function.modifiers = extraction.modifiers.noLessThanInternal()
        function.body = CodeBlockSyntax {
            buildDummyFunctionCallExpr(forType: function.signature.returnClause?.type)
        }
        return function
    }
}


