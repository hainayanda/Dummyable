//
//  DummyFuncCallExprBuilder.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

protocol DummyFuncCallExprBuilder {
    func buildDummyFuncCallExpr(forType type: TypeSyntax?) -> FunctionCallExprSyntax
}

// MARK: DummyFuncCallExprBuilder + Extension

extension DummyFuncCallExprBuilder {
    @inlinable func buildDummyFuncCallExpr(forType type: TypeSyntax?) -> FunctionCallExprSyntax {
        let type = type ?? TypeSyntax(IdentifierTypeSyntax(name: DummyableTokenSyntaxes.voidType))
        return FunctionCallExprSyntax(
            calledExpression: DeclReferenceExprSyntax(baseName: DummyableTokenSyntaxes.dummy),
            leftParen: .leftParenToken(),
            arguments: LabeledExprListSyntax {
                LabeledExprSyntax(
                    label: DummyableTokenSyntaxes.of,
                    colon: .colonToken(),
                    expression: MemberAccessExprSyntax(
                        base: DeclReferenceExprSyntax(baseName: .identifier(type.trimmedDescription)),
                        period: .periodToken(),
                        name: .keyword(.self)
                    )
                )
            },
            rightParen: .rightParenToken()
        )
    }
}
