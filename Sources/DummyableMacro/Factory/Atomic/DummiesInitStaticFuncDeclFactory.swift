//
//  DummiesStaticFuncDeclCodeFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

struct DummiesInitStaticFuncDeclFactory: DummyFuncCallCodeBuilder {

    let baseFactory: DummiesStaticFuncDeclFactory
    let initType: DeclReferenceExprSyntax
    let dummyInitializerParameters: [InitializerParameter]
    
    init(attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax, returnType: IdentifierTypeSyntax, initType: DeclReferenceExprSyntax, dummyInitializerParameters: [InitializerParameter]) {
        self.initType = initType
        self.dummyInitializerParameters = dummyInitializerParameters
        self.baseFactory = DummiesStaticFuncDeclFactory(
            attributes: attributes,
            modifiers: modifiers,
            returnType: returnType
        )
    }
    
    func buildDummyFuncDecl() -> ExtensionDeclSyntax {
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
            for parameter in dummyInitializerParameters {
                if let name = parameter.name {
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
