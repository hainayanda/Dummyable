//
//  DummyFuncDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummyFuncDeclFactory {
    
    typealias DTS = DummyableTokenSyntaxes
    
    let attributes: AttributeListSyntax
    let modifiers: DeclModifierListSyntax
    let genericParameters: GenericParameterClauseSyntax?
    let returnType: IdentifierTypeSyntax
    
    init(attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax, genericParameters: GenericParameterClauseSyntax? = nil, returnType: IdentifierTypeSyntax) {
        self.attributes = attributes
        self.modifiers = modifiers
        self.genericParameters = genericParameters
        self.returnType = returnType
    }
    
    @inlinable func buildDummyFuncDecl(codeBlockBuilder: @escaping () -> CodeBlockItemListSyntax) -> FunctionDeclSyntax {
        FunctionDeclSyntax(
            attributes: attributes,
            modifiers: modifiers,
            name: DTS.dummy,
            genericParameterClause: genericParameters,
            signature: buildDummyFuncSignature()) {
                codeBlockBuilder()
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
}
