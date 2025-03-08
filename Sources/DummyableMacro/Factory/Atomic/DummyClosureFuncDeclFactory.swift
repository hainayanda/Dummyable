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
    private let genericParameters: GenericParameterListSyntax?
    private let genericWhereClause: GenericWhereClauseSyntax?
    private let creationType: ClosureTypeCreation
    
    private var hasGenericParameters: Bool { genericParameters?.isEmpty == false }
    
    @inlinable init(closureType: ClosureType, attributes: AttributeListSyntax,
         modifiers: DeclModifierListSyntax, genericParameters: GenericParameterListSyntax? = nil,
         returnType: IdentifierTypeSyntax, genericWhereClause: GenericWhereClauseSyntax? = nil,
         creationType: ClosureTypeCreation) {
        self.closureType = closureType
        self.attributes = attributes
        self.modifiers = modifiers
        self.returnType = returnType
        self.genericParameters = genericParameters
        self.genericWhereClause = genericWhereClause
        self.creationType = creationType
    }
    
    @inlinable func buildDecl() -> DeclSyntax? {
        DeclSyntax(buildDummyFuncDecl())
    }
    
    private func buildDummyFuncDecl() -> FunctionDeclSyntax {
        DummyFuncDeclFactory(
            attributes: attributes,
            modifiers: modifiers,
            genericParametersClause: buildGenericParameterClause(),
            returnType: buildReturnType(forType: returnType),
            genericWhereClause: genericWhereClause
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
        guard closureType.rawValue > 0 || hasGenericParameters  else { return nil }
        var additive = 0
        return GenericParameterClauseSyntax {
            for index in 0 ..< closureType.rawValue {
                closureGenericParam(at: index, additive: &additive)
            }
            for parameter in genericParameters ?? [] {
                parameter
            }
        }
    }
    
    private func closureGenericParam(at index: Int, additive: inout Int) -> GenericParameterSyntax {
        while genericParameters?.contains(type: DTS.genericTypes[index + additive]) == true {
            additive += 1
        }
        return GenericParameterSyntax(name: DTS.genericTypes[index + additive])
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
        var additive = 0
        return IdentifierTypeSyntax(
            name: closureType.type,
            genericArgumentClause: GenericArgumentClauseSyntax(
                arguments: GenericArgumentListSyntax {
                    for index in 0 ..< closureType.rawValue {
                        genericArgumentSyntax(at: index, additive: &additive)
                    }
                    GenericArgumentSyntax(argument: type)
                }
            )
        )
    }
    
    private func genericArgumentSyntax(at index: Int, additive: inout Int) -> GenericArgumentSyntax {
        while genericParameters?.contains(type: DTS.genericTypes[index + additive]) == true {
            additive += 1
        }
        return GenericArgumentSyntax(
            argument: IdentifierTypeSyntax(
                name: DTS.genericTypes[index + additive]
            )
        )
    }
}

// MARK: DummyClosureFuncDeclFactory.ClosureType

extension DummyClosureFuncDeclFactory {
    enum ClosureType: Int {
        case noArg = 0
        case oneArg = 1
        case twoArgs = 2
        case threeArgs = 3
        case fourArgs = 4
        
        @inlinable var type: TokenSyntax {
            switch self {
            case .noArg:
                return DTS.closureType
            case .oneArg:
                return DTS.argClosureType
            case .twoArgs:
                return DTS.twoArgsClosureType
            case .threeArgs:
                return DTS.threeArgsClosureType
            case .fourArgs:
                return DTS.fourArgsClosureType
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

extension GenericParameterListSyntax {
    func contains(type: TokenSyntax) -> Bool {
        contains { parameter in
            parameter.name.trimmedDescription == type.trimmedDescription
        }
    }
}
