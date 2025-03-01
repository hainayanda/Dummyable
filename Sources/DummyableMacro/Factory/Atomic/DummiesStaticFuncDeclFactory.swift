//
//  Dumm.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummiesStaticFuncDeclFactory {
    
    typealias DTS = DummyableTokenSyntaxes
    
    let attributes: AttributeListSyntax
    let modifiers: DeclModifierListSyntax
    let returnType: IdentifierTypeSyntax
    
    init(attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax, returnType: IdentifierTypeSyntax) {
        self.attributes = attributes
        self.modifiers = modifiers
        self.returnType = returnType
    }
    
    func buildDummyFuncDecl(codeBlockBuilder: @escaping () -> CodeBlockItemListSyntax) -> ExtensionDeclSyntax {
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
                        codeBlockBuilder()
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
}
