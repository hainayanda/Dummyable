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
    private let isProtocol: Bool
    private let returnType: TypeSyntaxProtocol
    private let genericWhereClause: GenericWhereClauseSyntax?
    
    @inlinable init(
        attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax,
        genericParametersClause: GenericParameterClauseSyntax?, isProtocol: Bool,
        returnType: TypeSyntaxProtocol, genericWhereClause: GenericWhereClauseSyntax?) {
            self.attributes = attributes
            self.modifiers = modifiers
            self.genericParametersClause = genericParametersClause
            self.isProtocol = isProtocol
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
            returnClause: returnClause()
        )
    }
    
    private func buildDummyFuncParams(additionalParam: FunctionParameterListSyntax?) -> FunctionParameterListSyntax {
        FunctionParameterListSyntax {
            FunctionParameterSyntax(
                firstName: DTS.of,
                secondName: DTS.type,
                type: argumentType()
            )
            for param in additionalParam ?? [] {
                param
            }
        }
    }
    
    private func argumentType() -> TypeSyntaxProtocol {
        guard isProtocol else {
            return MemberTypeSyntax(
                baseType: returnType,
                name: DTS.typeType
            )
        }
        return MemberTypeSyntax(
            baseType: TupleTypeSyntax(elements: TupleTypeElementListSyntax {
                TupleTypeElementSyntax(
                    type: SomeOrAnyTypeSyntax(
                        someOrAnySpecifier: .keyword(.any),
                        constraint: returnType
                    )
                )
            }),
            name: DTS.typeType
        )
    }
    
    private func returnClause() -> ReturnClauseSyntax {
        guard isProtocol else {
            return ReturnClauseSyntax(type: returnType)
        }
        return ReturnClauseSyntax(
            type: SomeOrAnyTypeSyntax(
                someOrAnySpecifier: .keyword(.any),
                constraint: returnType
            )
        )
    }
}
