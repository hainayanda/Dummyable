//
//  DummyFuncForArrayDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 08/03/25.
//

import SwiftSyntax

struct DummyFuncForArrayDeclFactory: DeclBuilder, DummyClosureCreationExprBuilder {
    
    typealias DTS = DummyableTokenSyntaxes
    
    private let attributes: AttributeListSyntax
    private let modifiers: DeclModifierListSyntax
    private let elementType: IdentifierTypeSyntax
    private let genericParameters: GenericParameterListSyntax?
    private let genericWhereClause: GenericWhereClauseSyntax?
    private let creationType: DummyCreationType
    
    @inlinable init(
        attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax,
        genericParameters: GenericParameterListSyntax?, elementType: IdentifierTypeSyntax,
        genericWhereClause: GenericWhereClauseSyntax?, creationType: DummyCreationType) {
            self.attributes = attributes
            self.modifiers = modifiers
            self.elementType = elementType
            self.genericParameters = genericParameters
            self.genericWhereClause = genericWhereClause
            self.creationType = creationType
        }
    
    @inlinable func buildDecl() throws -> DeclSyntax? {
        DeclSyntax(buildDummyFuncDecl())
    }
    
    private func buildDummyFuncDecl() -> FunctionDeclSyntax {
        DummyFuncDeclFactory(
            attributes: attributes,
            modifiers: modifiers,
            genericParametersClause: buildGenericParameterClause(),
            isProtocol: false,
            returnType: ArrayTypeSyntax(element: elementType),
            genericWhereClause: genericWhereClause
        )
        .buildDummyFuncDecl(additionalParam: buildAdditionalParam()) {
            CodeBlockItemListSyntax {
                FunctionCallExprSyntax(
                    calledExpression: DeclReferenceExprSyntax(
                        baseName: DTS.arrayType
                    ),
                    leftParen: .leftParenToken(),
                    arguments: buildArrayInitArguments(),
                    rightParen: .rightParenToken(),
                    trailingClosure: buildTrailingClosure()
                )
            }
        }
    }
    
    private func buildGenericParameterClause() -> GenericParameterClauseSyntax? {
        guard let genericParameters else { return nil }
        return GenericParameterClauseSyntax(parameters: genericParameters)
    }
    
    private func buildAdditionalParam() -> FunctionParameterListSyntax {
        FunctionParameterListSyntax {
            FunctionParameterSyntax(
                firstName: DTS.count,
                type: IdentifierTypeSyntax(name: DTS.intType)
            )
        }
    }
    
    private func buildArrayInitArguments() -> LabeledExprListSyntax {
        LabeledExprListSyntax {
            LabeledExprSyntax(
                label: DTS.repeat,
                colon: .colonToken(),
                expression: DeclReferenceExprSyntax(baseName: DTS.count)
            )
        }
    }
    
    private func buildTrailingClosure() -> ClosureExprSyntax {
        ClosureExprSyntax {
            buildClosureCodeBlock(
                for: creationType,
                returnType: DeclReferenceExprSyntax(
                    baseName: .identifier(elementType.trimmedDescription)
                )
            )
        }
    }
}
