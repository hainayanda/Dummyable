//
//  DummyFuncUsingInitDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

struct DummyFuncUsingInitDeclFactory: DeclBuilder, DummyFuncCallExprBuilder {
    
    private let baseFactory: DummyFuncDeclFactory
    private let initType: DeclReferenceExprSyntax
    private let dummyInitParameters: [InitializerParameter]
    
    @inlinable init(
        attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax,
        genericParameters: GenericParameterListSyntax? = nil, returnType: IdentifierTypeSyntax,
        genericWhereClause: GenericWhereClauseSyntax? = nil, initType: DeclReferenceExprSyntax,
        dummyInitializerParameters: [InitializerParameter]) {
            self.initType = initType
            self.dummyInitParameters = dummyInitializerParameters
            self.baseFactory = DummyFuncDeclFactory(
                attributes: attributes,
                modifiers: modifiers,
                genericParametersClause: genericParameters.asGenericParametersClause,
                returnType: returnType,
                genericWhereClause: genericWhereClause
            )
        }
    
    @inlinable func buildDecl() -> DeclSyntax? {
        DeclSyntax(buildDummyFuncDecl())
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

extension Optional where Wrapped == GenericParameterListSyntax {
    @inlinable var asGenericParametersClause: GenericParameterClauseSyntax? {
        guard let self = self, !self.isEmpty else {
            return nil
        }
        return GenericParameterClauseSyntax(parameters: self)
    }
}
