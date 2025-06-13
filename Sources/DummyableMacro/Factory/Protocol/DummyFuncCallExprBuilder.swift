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
                        base: buildDummyFuncBaseExpr(forType: type),
                        period: .periodToken(),
                        name: .keyword(.self)
                    )
                )
            },
            rightParen: .rightParenToken()
        )
    }
    
    private func buildDummyFuncBaseExpr(forType type: TypeSyntax) -> ExprSyntaxProtocol {
        return if let anyTypeSyntax = type.as(SomeOrAnyTypeSyntax.self) {
            TupleExprSyntax(elements: LabeledExprListSyntax {
                LabeledExprSyntax(
                    expression: DeclReferenceExprSyntax(
                        baseName: .identifier(anyTypeSyntax.trimmedDescription)
                    )
                )
            })
        } else {
            DeclReferenceExprSyntax(baseName: .identifier(type.trimmedDescription))
        }
        
    }
}
