//
//  DummyFuncCallCodeBuilder.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

protocol DummyFuncCallCodeBuilder {
    func buildDummyFunctionCallExpr(forType type: TypeSyntax?) throws -> FunctionCallExprSyntax
}

extension DummyFuncCallCodeBuilder {
    func buildDummyFunctionCallExpr(forType type: TypeSyntax?) -> FunctionCallExprSyntax {
        let type = type ?? TypeSyntax(IdentifierTypeSyntax(name: DummyableTokenSyntaxes.voidType))
        return FunctionCallExprSyntax(
            calledExpression: MemberAccessExprSyntax(
                base: DeclReferenceExprSyntax(
                    baseName: .identifier(DummyableTokenSyntaxes.dummiesType.trimmedDescription)
                ),
                name: .identifier(DummyableTokenSyntaxes.dummy.trimmedDescription)
            ),
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
