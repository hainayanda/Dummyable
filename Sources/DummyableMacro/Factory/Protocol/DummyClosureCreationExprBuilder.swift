//
//  DummyClosureCreationExprBuilder.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 08/03/25.
//

import SwiftSyntax

protocol DummyClosureCreationExprBuilder {
    func buildClosureCodeBlock(for creationType: DummyCreationType, returnType: DeclReferenceExprSyntax) -> CodeBlockItemListSyntax
}

extension DummyClosureCreationExprBuilder {
    
    typealias DTS = DummyableTokenSyntaxes
    
    @inlinable func buildClosureCodeBlock(
        for creationType: DummyCreationType,
        returnType: DeclReferenceExprSyntax) -> CodeBlockItemListSyntax {
        CodeBlockItemListSyntax {
            switch creationType {
            case .emptyInitCall(let type):
                buildDummyInitCall(forType: type)
            case .dummyFuncCall:
                buildDummyFuncCall(returnType: returnType)
            case .codeBlock(let codeBlock):
                codeBlock
            }
        }
    }
    
    private func buildDummyInitCall(forType type: TokenSyntax)  -> FunctionCallExprSyntax {
        FunctionCallExprSyntax(
            calledExpression: DeclReferenceExprSyntax(baseName: .identifier(type.trimmedDescription)),
            leftParen: .leftParenToken(),
            arguments: [],
            rightParen: .rightParenToken()
        )
    }
    
    private func buildDummyFuncCall(returnType: DeclReferenceExprSyntax) -> FunctionCallExprSyntax {
        FunctionCallExprSyntax(
            calledExpression: DeclReferenceExprSyntax(baseName: DTS.dummy),
            leftParen: .leftParenToken(),
            arguments: LabeledExprListSyntax {
                LabeledExprSyntax(
                    label: DTS.of,
                    colon: .colonToken(),
                    expression: MemberAccessExprSyntax(
                        base: returnType,
                        period: .periodToken(),
                        name: .keyword(.self)
                    )
                )
            },
            rightParen: .rightParenToken()
        )
    }
}
