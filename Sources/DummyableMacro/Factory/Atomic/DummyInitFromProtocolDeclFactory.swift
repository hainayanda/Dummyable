//
//  DummyInitFromProtocolDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

struct DummyInitFromProtocolDeclFactory: DummyFuncCallCodeBuilder {
    
    let modifiers: DeclModifierListSyntax
    let baseInit: InitializerDeclSyntax
    let mandatoryVariables: [VariableDeclExtraction]
    
    func buildInitDecl() -> InitializerDeclSyntax {
        var modifiedInit = baseInit
        modifiedInit.modifiers = modifiers
        modifiedInit.body = CodeBlockSyntax(statements: buildInitBodyCodeBlock())
        return modifiedInit
    }
    
    private func buildInitBodyCodeBlock() -> CodeBlockItemListSyntax {
        CodeBlockItemListSyntax {
            for variable in mandatoryVariables {
                SequenceExprSyntax {
                    MemberAccessExprSyntax(
                        base: DeclReferenceExprSyntax(baseName: .keyword(.self)),
                        period: .periodToken(),
                        name: .identifier(variable.name.trimmedDescription)
                    )
                    AssignmentExprSyntax()
                    buildDummyFunctionCallExpr(
                        forType: variable.typeAnotation.type
                    )
                }
            }
        }
    }
}
