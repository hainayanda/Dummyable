//
//  DummyProtocolInitDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

struct DummyProtocolInitDeclFactory: DummyFuncCallExprBuilder {
    
    let modifiers: DeclModifierListSyntax
    let baseInit: InitializerDeclSyntax
    let mandatoryVariables: [VariableDeclExtraction]
    
    @inlinable func buildInitDecl() -> InitializerDeclSyntax {
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
                    buildDummyFuncCallExpr(
                        forType: variable.typeAnotation.type
                    )
                }
            }
        }
    }
}
