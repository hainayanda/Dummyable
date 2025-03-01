//
//  DummiesStaticFuncDeclCodeFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

struct DummiesStaticFuncDeclFactory: DummyFuncCallCodeBuilder {
    
    typealias DTS = DummyableTokenSyntaxes
    
    let attributes: AttributeListSyntax
    let modifiers: DeclModifierListSyntax
    let returnType: IdentifierTypeSyntax
    let initType: DeclReferenceExprSyntax
    let dummyInitializerParameters: [InitializerParameter]
    
    init(attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax, returnType: IdentifierTypeSyntax, initType: DeclReferenceExprSyntax, dummyInitializerParameters: [InitializerParameter]) {
        self.attributes = attributes
        self.modifiers = modifiers
        self.returnType = returnType
        self.initType = initType
        self.dummyInitializerParameters = dummyInitializerParameters
    }
    
    func buildDummyFuncDecl() -> ExtensionDeclSyntax {
        ExtensionDeclSyntax(
            attributes: attributes,
            modifiers: modifiers,
            extendedType: IdentifierTypeSyntax(name: DTS.dummiesType)
        ) {
            MemberBlockItemSyntax(
                decl: FunctionDeclSyntax(
                    modifiers: DeclModifierListSyntax {
                        DeclModifierSyntax(name: .keyword(.static))
                    },
                    name: DTS.dummy,
                    signature: buildDummyFuncSignature()) {
                        buildDummyableInitializeCodeBlock()
                    }
            )
        }
    }
    
    private func buildDummyFuncSignature() -> FunctionSignatureSyntax {
        FunctionSignatureSyntax(
            parameterClause: FunctionParameterClauseSyntax(parameters: buildDummyFuncParams()),
            returnClause: ReturnClauseSyntax(type: returnType)
        )
    }
    
    private func buildDummyFuncParams() -> FunctionParameterListSyntax {
        FunctionParameterListSyntax {
            FunctionParameterSyntax(
                firstName: DTS.of,
                secondName: DTS.type,
                type: MemberTypeSyntax(
                    baseType: returnType,
                    name: DTS.typeType
                )
            )
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

