//
//  DummyableInitCodeBuilder.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

protocol DummyableInitCodeBuilder: DummyFuncCallCodeBuilder {
    var typeDeclExtraction: TypeDeclExtracting { get }
    func buildInitDecl() throws -> InitializerDeclSyntax
    func buildInitModifiers() throws -> DeclModifierListSyntax
    func buildInitParamClause() throws -> FunctionParameterClauseSyntax
    func buildInitBodyCodeBlock() throws -> CodeBlockItemListSyntax
}

extension DummyableInitCodeBuilder {
    func buildInitDecl() throws -> InitializerDeclSyntax {
        try InitializerDeclSyntax(
            modifiers: buildInitModifiers(),
            signature: FunctionSignatureSyntax(
                parameterClause: buildInitParamClause()
            ),
            body: CodeBlockSyntax(
                statements: buildInitBodyCodeBlock()
            )
        )
    }
    
    func buildInitParamClause() throws -> FunctionParameterClauseSyntax {
        FunctionParameterClauseSyntax(
            parameters: try FunctionParameterListSyntax {
                for variableExtraction in typeDeclExtraction.variablesNeededForInit.extractions() {
                    try buildInitParameter(from: variableExtraction)
                }
            }
        )
    }
    
    private func buildInitParameter(from variableExtraction: VariableDeclExtraction) throws -> FunctionParameterSyntax {
        return FunctionParameterSyntax(
            firstName: .identifier(variableExtraction.name.trimmedDescription),
            type: variableExtraction.typeAnotation.type,
            defaultValue: InitializerClauseSyntax(
                value: try buildDummyFunctionCallExpr(
                    forType: variableExtraction.typeAnotation.type
                )
            )
        )
    }
}
