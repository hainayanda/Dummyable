//
//  DummyInitFuncDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

struct DummyInitFuncDeclFactory: DummyFuncCallExprBuilder {

    private let baseFactory: DummyFuncDeclFactory
    private let initType: DeclReferenceExprSyntax
    private let dummyInitParameters: [InitializerParameter]
    
    @inlinable init(attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax, returnType: IdentifierTypeSyntax, initType: DeclReferenceExprSyntax, dummyInitializerParameters: [InitializerParameter]) {
        self.initType = initType
        self.dummyInitParameters = dummyInitializerParameters
        self.baseFactory = DummyFuncDeclFactory(
            attributes: attributes,
            modifiers: modifiers,
            returnType: returnType
        )
    }
    
    @inlinable func buildDummyFuncDecl() -> FunctionDeclSyntax {
        baseFactory.buildDummyFuncDecl {
            buildDummyableInitializeCodeBlock()
        }
    }
    
    private func buildDummyableInitializeCodeBlock() -> CodeBlockItemListSyntax {
        CodeBlockItemListSyntax {
            FunctionCallExprSyntax(
                calledExpression: initType,
                leftParen: .leftParenToken(),
                arguments: buildDummyableInitializerArguments(),
                rightParen: .rightParenToken()
            )
        }
    }
    
    private func buildDummyableInitializerArguments() -> LabeledExprListSyntax {
        LabeledExprListSyntax {
            for parameter in dummyInitParameters {
                if let name = parameter.name {
                    LabeledExprSyntax(
                        label: name,
                        colon: .colonToken(),
                        expression: buildDummyFuncCallExpr(forType: parameter.type)
                    )
                } else {
                    LabeledExprSyntax(
                        expression: buildDummyFuncCallExpr(forType: parameter.type)
                    )
                }
            }
            
        }
    }
}
