//
//  DummyMemberwiseInitDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

struct DummyMemberwiseInitDeclFactory: DummyFuncCallExprBuilder {
    
    let modifiers: DeclModifierListSyntax
    let parameters: [InitMemberwiseParam]
    
    @inlinable func buildInitDecl() -> InitializerDeclSyntax {
        InitializerDeclSyntax(
            modifiers: modifiers,
            signature: FunctionSignatureSyntax(
                parameterClause: buildInitParamClause()
            ),
            body: CodeBlockSyntax(
                statements: buildInitBodyCodeBlock()
            )
        )
    }
    
    private func buildInitBodyCodeBlock() -> CodeBlockItemListSyntax {
        CodeBlockItemListSyntax {
            for parameter in parameters {
                SequenceExprSyntax {
                    MemberAccessExprSyntax(
                        base: DeclReferenceExprSyntax(baseName: .keyword(.self)),
                        period: .periodToken(),
                        name: parameter.parameterName
                    )
                    AssignmentExprSyntax()
                    DeclReferenceExprSyntax(
                        baseName: parameter.destination
                    )
                }
            }
        }
    }
    
    private func buildInitParamClause() -> FunctionParameterClauseSyntax {
        FunctionParameterClauseSyntax(
            parameters: FunctionParameterListSyntax {
                for parameter in parameters {
                    parameter.raw.withDefaultValue(
                        InitializerClauseSyntax(
                            value: buildDummyFuncCallExpr(
                                forType: parameter.type
                            )
                        )
                    )
                }
            }
        )
    }
}
