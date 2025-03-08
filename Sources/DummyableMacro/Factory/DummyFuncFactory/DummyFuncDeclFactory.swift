//
//  DummyFuncDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummyFuncDeclFactory {
    
    typealias DTS = DummyableTokenSyntaxes
    
    private let attributes: AttributeListSyntax
    private let modifiers: DeclModifierListSyntax
    private let genericParametersClause: GenericParameterClauseSyntax?
    private let returnType: TypeSyntaxProtocol
    private let genericWhereClause: GenericWhereClauseSyntax?
    
    @inlinable init(
        attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax,
        genericParametersClause: GenericParameterClauseSyntax?, returnType: TypeSyntaxProtocol,
        genericWhereClause: GenericWhereClauseSyntax?) {
            self.attributes = attributes
            self.modifiers = modifiers
            self.genericParametersClause = genericParametersClause
            self.returnType = returnType
            self.genericWhereClause = genericWhereClause
        }
    
    @inlinable func buildDummyFuncDecl(
        additionalParam: FunctionParameterListSyntax? = nil,
        codeBlockBuilder: @escaping () -> CodeBlockItemListSyntax) -> FunctionDeclSyntax {
            FunctionDeclSyntax(
                attributes: attributes,
                modifiers: modifiers,
                name: DTS.dummy,
                genericParameterClause: genericParametersClause,
                signature: buildDummyFuncSignature(additionalParam: additionalParam),
                genericWhereClause: genericWhereClause) {
                    codeBlockBuilder()
                }
        }
    
    private func buildDummyFuncSignature(additionalParam: FunctionParameterListSyntax?) -> FunctionSignatureSyntax {
        FunctionSignatureSyntax(
            parameterClause: FunctionParameterClauseSyntax(
                parameters: buildDummyFuncParams(additionalParam: additionalParam)
            ),
            returnClause: ReturnClauseSyntax(type: returnType)
        )
    }
    
    private func buildDummyFuncParams(additionalParam: FunctionParameterListSyntax?) -> FunctionParameterListSyntax {
        FunctionParameterListSyntax {
            FunctionParameterSyntax(
                firstName: DTS.of,
                secondName: DTS.type,
                type: MemberTypeSyntax(
                    baseType: returnType,
                    name: DTS.typeType
                )
            )
            for param in additionalParam ?? [] {
                param
            }
        }
    }
}
