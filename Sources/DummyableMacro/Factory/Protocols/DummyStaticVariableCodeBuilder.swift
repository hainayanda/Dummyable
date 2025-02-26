//
//  DummyStaticVariableCodeBuilder.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

protocol DummyStaticVariableCodeBuilder: DummyFuncCallCodeBuilder {
    var typeDeclExtraction: TypeDeclExtracting { get }
    var staticDummyType: TokenSyntax { get }
    var dummyInitializerParameters: [ParameterDeclExtraction] { get }
    func buildDummyStaticVariableDecl() throws -> VariableDeclSyntax
    func buildDummyableInitializeCodeBlock() throws -> CodeBlockItemListSyntax
}

extension DummyStaticVariableCodeBuilder {
    
    func buildDummyStaticVariableDecl() throws -> VariableDeclSyntax {
        VariableDeclSyntax(
            modifiers: DeclModifierListSyntax {
                typeDeclExtraction.modifiers
                DeclModifierSyntax(name: .keyword(.static))
            },
            bindingSpecifier: .keyword(.var),
            bindings: try PatternBindingListSyntax {
                PatternBindingSyntax(
                    pattern: IdentifierPatternSyntax(identifier: DummyableTokenSyntaxes.dummy),
                    typeAnnotation: TypeAnnotationSyntax(
                        type: IdentifierTypeSyntax(name: staticDummyType)
                    ),
                    accessorBlock: AccessorBlockSyntax(
                        accessors: .getter(try buildDummyableInitializeCodeBlock())
                    )
                )
            }
        )
    }
    
    func buildDummyableInitializeCodeBlock() throws -> CodeBlockItemListSyntax {
        try CodeBlockItemListSyntax {
            FunctionCallExprSyntax(
                calledExpression: DeclReferenceExprSyntax(baseName: staticDummyType),
                leftParen: .leftParenToken(),
                arguments: try buildDummyableInitializerArguments(),
                rightParen: .rightParenToken()
            )
        }
    }
    
    private func buildDummyableInitializerArguments() throws -> LabeledExprListSyntax {
        try LabeledExprListSyntax {
            for parameter in dummyInitializerParameters {
                if let name = parameter.name {
                    try LabeledExprSyntax(
                        label: .identifier(name.trimmedDescription),
                        colon: .colonToken(),
                        expression: buildDummyFunctionCallExpr(forType: parameter.type)
                    )
                } else {
                    try LabeledExprSyntax(
                        expression: buildDummyFunctionCallExpr(forType: parameter.type)
                    )
                }
            }
                    
        }
    }
}
