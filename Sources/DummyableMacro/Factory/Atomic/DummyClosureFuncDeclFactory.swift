//
//  DummyClosureFuncDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummyClosureFuncDeclFactory: DeclBuilder {
    
    typealias DTS = DummyableTokenSyntaxes
    
    private let closureType: ClosureType
    private let attributes: AttributeListSyntax
    private let modifiers: DeclModifierListSyntax
    private let returnType: IdentifierTypeSyntax
    private let creationType: ClosureTypeCreation
    
    init(closureType: ClosureType, attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax, returnType: IdentifierTypeSyntax, creationType: ClosureTypeCreation) {
        self.closureType = closureType
        self.attributes = attributes
        self.modifiers = modifiers
        self.returnType = returnType
        self.creationType = creationType
    }
    
    func buildDecl() -> DeclSyntax? {
        DeclSyntax(buildDummyFuncDecl())
    }
    
    private func buildDummyFuncDecl() -> FunctionDeclSyntax {
        DummyFuncDeclFactory(
            attributes: attributes,
            modifiers: modifiers,
            genericParameters: buildGenericParameterClause(),
            returnType: buildReturnType(forType: returnType)
        )
        .buildDummyFuncDecl {
            CodeBlockItemListSyntax {
                ClosureExprSyntax(
                    signature: buildClosureSignature(),
                    statements: buildClosureCodeBlock()
                )
            }
        }
    }
    
    private func buildGenericParameterClause() -> GenericParameterClauseSyntax? {
        guard closureType.rawValue > 0 else { return nil }
        return GenericParameterClauseSyntax {
            GenericParameterSyntax(name: DTS.aType)
            if closureType.rawValue > 1 {
                GenericParameterSyntax(name: DTS.bType)
            }
            if closureType.rawValue > 2 {
                GenericParameterSyntax(name: DTS.cType)
            }
            if closureType.rawValue > 3 {
                GenericParameterSyntax(name: DTS.dType)
            }
        }
    }
    
    private func buildClosureSignature() -> ClosureSignatureSyntax? {
        guard closureType.rawValue > 0 else { return nil }
        return ClosureSignatureSyntax(
            parameterClause: .simpleInput(ClosureShorthandParameterListSyntax {
                for _ in 0 ..< closureType.rawValue {
                    ClosureShorthandParameterSyntax(name: DTS.underscore)
                }
            })
        )
    }
    
    private func buildClosureCodeBlock() -> CodeBlockItemListSyntax {
        CodeBlockItemListSyntax {
            switch creationType {
            case .emptyInitCall(let type):
                buildDummyInitCall(forType: type)
            case .dummyFuncCall:
                buildDummyFuncCall()
            case .codeBlock(let codeBlock):
                codeBlock
            }
        }
    }
    
    private func buildDummyInitCall(forType type: TokenSyntax)  -> FunctionCallExprSyntax {
        FunctionCallExprSyntax(
            calledExpression: DeclReferenceExprSyntax(baseName: .identifier(type.trimmedDescription)),
            leftParen: .leftParenToken(),
            arguments: [],
            rightParen: .rightParenToken()
        )
    }
    
    private func buildDummyFuncCall() -> FunctionCallExprSyntax {
        FunctionCallExprSyntax(
            calledExpression: DeclReferenceExprSyntax(baseName: DTS.dummy),
            leftParen: .leftParenToken(),
            arguments: LabeledExprListSyntax {
                LabeledExprSyntax(
                    label: DTS.of,
                    colon: .colonToken(),
                    expression: MemberAccessExprSyntax(
                        base: DeclReferenceExprSyntax(baseName: .identifier(returnType.trimmedDescription)),
                        period: .periodToken(),
                        name: .keyword(.self)
                    )
                )
            },
            rightParen: .rightParenToken()
        )
    }
    
    private func buildReturnType(forType type: IdentifierTypeSyntax) -> IdentifierTypeSyntax {
        IdentifierTypeSyntax(
            name: closureType.type,
            genericArgumentClause: GenericArgumentClauseSyntax(
                arguments: GenericArgumentListSyntax {
                    if closureType.rawValue > 0 {
                        GenericArgumentSyntax(argument: IdentifierTypeSyntax(name: DTS.aType))
                    }
                    if closureType.rawValue > 1 {
                        GenericArgumentSyntax(argument: IdentifierTypeSyntax(name: DTS.bType))
                    }
                    if closureType.rawValue > 2 {
                        GenericArgumentSyntax(argument: IdentifierTypeSyntax(name: DTS.cType))
                    }
                    if closureType.rawValue > 3 {
                        GenericArgumentSyntax(argument: IdentifierTypeSyntax(name: DTS.dType))
                    }
                    GenericArgumentSyntax(argument: type)
                }
            )
        )
    }
}

// MARK: DummyClosureFuncDeclFactory.ClosureType

extension DummyClosureFuncDeclFactory {
    enum ClosureType: Int {
        case noArg = 0
        case oneArg = 1
        case twoArg = 2
        case threeArg = 3
        case fourArg = 4
        
        var type: TokenSyntax {
            switch self {
            case .noArg:
                return DTS.closureType
            case .oneArg:
                return DTS.argClosureType
            case .twoArg:
                return DTS.twoArgClosureType
            case .threeArg:
                return DTS.threeArgClosureType
            case .fourArg:
                return DTS.fourArgClosureType
            }
        }
    }
}

// MARK: DummyClosureFuncDeclFactory.ClosureTypeCreation

extension DummyClosureFuncDeclFactory {
    enum ClosureTypeCreation {
        case dummyFuncCall
        case emptyInitCall(TokenSyntax)
        case codeBlock(CodeBlockItemListSyntax)
    }
}
