//
//  DummyConcreteInitCodeBuilder.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

protocol DummyConcreteInitCodeBuilder:
    DummyableInitCodeBuilder,
    DummyStaticVariableCodeBuilder {
}

extension DummyConcreteInitCodeBuilder {
    func buildInitModifiers() throws -> DeclModifierListSyntax {
        typeDeclExtraction.modifiers
    }
    
    func buildInitBodyCodeBlock() throws -> CodeBlockItemListSyntax {
        CodeBlockItemListSyntax {
            for variable in typeDeclExtraction.variablesNeededForInit.extractions() {
                SequenceExprSyntax {
                    MemberAccessExprSyntax(
                        base: DeclReferenceExprSyntax(baseName: .keyword(.self)),
                        period: .periodToken(),
                        name: .identifier(variable.name.trimmedDescription)
                    )
                    AssignmentExprSyntax()
                    DeclReferenceExprSyntax(
                        baseName: .identifier(variable.name.trimmedDescription)
                    )
                }
            }
        }
    }
}
