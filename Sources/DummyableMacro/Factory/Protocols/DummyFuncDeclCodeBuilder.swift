//
//  DummyFuncDeclCodeBuilder.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

protocol DummyFuncDeclCodeBuilder {
    var typeDeclExtraction: TypeDeclExtracting { get }
    var dummyFuncParamType: TokenSyntax { get }
    var dummyFuncInitType: TokenSyntax { get }
    func buildDummyFuncDecl() throws -> ExtensionDeclSyntax
}

extension DummyFuncDeclCodeBuilder {
    
    typealias DTS = DummyableTokenSyntaxes
    
    func buildDummyFuncDecl() throws -> ExtensionDeclSyntax {
        ExtensionDeclSyntax(
            attributes: AttributeListSyntax(typeDeclExtraction.availableAttributes),
            modifiers: typeDeclExtraction.modifiers,
            extendedType: IdentifierTypeSyntax(name: DTS.dummiesType)
        ) {
            MemberBlockItemSyntax(
                decl: FunctionDeclSyntax(
                    modifiers: DeclModifierListSyntax {
                        DeclModifierSyntax(name: .keyword(.static))
                    },
                    name: DTS.dummy,
                    signature: buildDummyFuncSignature()) {
                        buildDummyAccessingBlock()
                    }
            )
        }
    }
    
    private func buildDummyFuncSignature() -> FunctionSignatureSyntax {
        FunctionSignatureSyntax(
            parameterClause: FunctionParameterClauseSyntax(parameters: buildDummyFuncParams()),
            returnClause: ReturnClauseSyntax(type: IdentifierTypeSyntax(name: dummyFuncParamType))
        )
    }
    
    private func buildDummyFuncParams() -> FunctionParameterListSyntax {
        FunctionParameterListSyntax {
            FunctionParameterSyntax(
                firstName: DTS.of,
                secondName: DTS.type,
                type: MemberTypeSyntax(
                    baseType: IdentifierTypeSyntax(name: dummyFuncParamType),
                    name: DTS.typeType
                )
            )
        }
    }
    
    private func buildDummyAccessingBlock() -> CodeBlockItemListSyntax {
        CodeBlockItemListSyntax {
            MemberAccessExprSyntax(
                base: DeclReferenceExprSyntax(baseName: dummyFuncInitType),
                name: DTS.dummy
            )
        }
    }
}
