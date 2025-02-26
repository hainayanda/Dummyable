//
//  DummyOnProtocolDeclMacroFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

struct DummyOnProtocolDeclMacroFactory: DeclSyntaxExpander, DummyConcreteInitCodeBuilder {
    
    typealias DTS = DummyableTokenSyntaxes
    
    let extraction: ProtocolDeclExtraction
    var typeDeclExtraction: TypeDeclExtracting { extraction }
    var staticDummyType: TokenSyntax { extraction.generationName }
    var dummyInitializerParameters: [ParameterDeclExtraction] { [] }
    
    init(extraction: ProtocolDeclExtraction) {
        self.extraction = extraction
    }
    
    func expandDeclCodeGeneration() throws -> DeclSyntax {
        return switch try extraction.generationType {
        case .class:
            try DeclSyntax(expandClassCodeGeneration())
        case .struct:
            try DeclSyntax(expandStructCodeGeneration())
        }
    }
    
    private func expandStructCodeGeneration() throws -> StructDeclSyntax {
        try StructDeclSyntax(
            attributes: AttributeListSyntax(extraction.availableAttributes),
            modifiers: extraction.modifiers,
            name: extraction.generationName,
            inheritanceClause: buildInherintanceClause()
        ) {
            try buildDummyStaticVariableDecl()
            for variable in extraction.variablesNeededForInit {
                try buildVariableDecl(from: variable)
            }
            try buildInitDecl()
            for function in extraction.mandatoryFunctions {
                buildFuncDecl(from: function)
            }
        }
    }
    
    private func expandClassCodeGeneration() throws -> ClassDeclSyntax {
        try ClassDeclSyntax(
            attributes: AttributeListSyntax(extraction.availableAttributes),
            modifiers: extraction.modifiers.withFinalModifier(),
            name: extraction.generationName,
            inheritanceClause: buildInherintanceClause()
        ) {
            try buildDummyStaticVariableDecl()
            for variable in extraction.variablesNeededForInit {
                try buildVariableDecl(from: variable)
            }
            try buildInitDecl()
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
                InheritedTypeSyntax(
                    type: IdentifierTypeSyntax(name: DTS.dummyableType)
                )
            }
        )
    }
    
    private func buildVariableDecl(from variable: VariableDeclSyntax) throws -> VariableDeclSyntax {
        guard let variableExtraction = variable.extraction else {
            throw DummyableMacroError.failToGenerateMacro
        }
        var variable = variable
        variable.modifiers = extraction.modifiers
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
        function.modifiers = extraction.modifiers
        function.body = CodeBlockSyntax {
            buildDummyFunctionCallExpr(forType: function.signature.returnClause?.type)
        }
        return function
    }
}


