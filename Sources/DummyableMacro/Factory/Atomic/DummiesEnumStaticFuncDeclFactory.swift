//
//  DummiesEnumStaticFuncDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummiesEnumStaticFuncDeclFactory: DummyFuncCallCodeBuilder {
    
    let baseFactory: DummiesStaticFuncDeclFactory
    let enumCase: EnumCaseElementSyntax
    
    init(attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax, returnType: IdentifierTypeSyntax, enumCase: EnumCaseElementSyntax) {
        self.baseFactory = DummiesStaticFuncDeclFactory(
            attributes: attributes,
            modifiers: modifiers,
            returnType: returnType
        )
        self.enumCase = enumCase
    }
    
    func builDummiesExtDecl() -> ExtensionDeclSyntax {
        baseFactory.builDummiesExtDecl {
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
                        expression: buildDummyFunctionCallExpr(forType: parameter.type)
                    )
                } else {
                    LabeledExprSyntax(
                        expression: buildDummyFunctionCallExpr(forType: parameter.type)
                    )
                }
            }
            
        }
    }
}
