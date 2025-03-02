//
//  DummyEnumFuncDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummyEnumFuncDeclFactory: DummyFuncCallExprBuilder {
    
    private let baseFactory: DummyFuncDeclFactory
    private let enumCase: EnumCaseElementSyntax
    
    @inlinable init(attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax, returnType: IdentifierTypeSyntax, enumCase: EnumCaseElementSyntax) {
        self.baseFactory = DummyFuncDeclFactory(
            attributes: attributes,
            modifiers: modifiers,
            returnType: returnType
        )
        self.enumCase = enumCase
    }
    
    @inlinable func buildDummyFuncDecl() -> FunctionDeclSyntax {
        baseFactory.buildDummyFuncDecl {
            buildDummyableCaseCodeBlock()
        }
    }
    
    private func buildDummyableCaseCodeBlock() -> CodeBlockItemListSyntax {
        CodeBlockItemListSyntax {
            if let parameters = enumCase.parameterClause?.parameters {
                FunctionCallExprSyntax(
                    calledExpression: MemberAccessExprSyntax(
                        period: .periodToken(),
                        name: enumCase.name.trimmed
                    ),
                    leftParen: .leftParenToken(),
                    arguments: buildCaseArguments(from: parameters),
                    rightParen: .rightParenToken()
                )
            } else {
                MemberAccessExprSyntax(
                    period: .periodToken(),
                    name: enumCase.name.trimmed
                )
            }
        }
    }
    
    private func buildCaseArguments(from parameters: EnumCaseParameterListSyntax) -> LabeledExprListSyntax {
        LabeledExprListSyntax {
            for parameter in parameters {
                if let name = parameter.firstName {
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
