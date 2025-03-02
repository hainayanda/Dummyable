//
//  StaticDummyFuncDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct StaticDummyFuncDeclFactory {
    
    typealias DTS = DummyableTokenSyntaxes
    
    let returnType: IdentifierTypeSyntax
    
    func buildDummyFuncDecl(codeBlockBuilder: @escaping () -> CodeBlockItemListSyntax) -> FunctionDeclSyntax {
        FunctionDeclSyntax(
            modifiers: DeclModifierListSyntax {
                DeclModifierSyntax(name: .keyword(.static))
            },
            name: DTS.dummy,
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
