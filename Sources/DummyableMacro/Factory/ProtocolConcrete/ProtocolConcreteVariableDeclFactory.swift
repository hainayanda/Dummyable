//
//  .swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct ProtocolConcreteVariableDeclFactory {
    
    private let modifiers: DeclModifierListSyntax
    private let baseVariable: VariableDeclSyntax
    
    @inlinable init(modifiers: DeclModifierListSyntax, baseVariable: VariableDeclSyntax) {
        self.modifiers = modifiers
        self.baseVariable = baseVariable
    }
    
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
