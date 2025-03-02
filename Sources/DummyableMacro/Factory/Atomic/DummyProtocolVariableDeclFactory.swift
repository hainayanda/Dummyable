//
//  DummyProtocolVariableDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummyProtocolVariableDeclFactory {
    
    let modifiers: DeclModifierListSyntax
    let baseVariable: VariableDeclSyntax
    
    @inlinable func buildVariableDecl() throws -> VariableDeclSyntax {
        guard let variableExtraction = baseVariable.extraction else {
            throw DummyableMacroError.failToGenerateMacro
        }
        var modifiedVariable = baseVariable
        modifiedVariable.modifiers = modifiers
        modifiedVariable.bindings = PatternBindingListSyntax {
            PatternBindingSyntax(
                pattern: variableExtraction.name,
                typeAnnotation: variableExtraction.typeAnotation
            )
        }
        return modifiedVariable
    }
}
