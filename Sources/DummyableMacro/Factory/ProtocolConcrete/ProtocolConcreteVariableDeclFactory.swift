//
//  .swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct ProtocolConcreteVariableDeclFactory: DummyFuncCallExprBuilder {
    
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
        modifiedVariable.bindingSpecifier = baseVariable.hasSetter ? .keyword(.var) : .keyword(.let)
        modifiedVariable.bindings = PatternBindingListSyntax {
            PatternBindingSyntax(
                pattern: variableExtraction.name,
                typeAnnotation: variableExtraction.typeAnotation,
                initializer: InitializerClauseSyntax(
                    value: buildDummyFuncCallExpr(forType: variableExtraction.typeAnotation.type)
                )
            )
        }
        return modifiedVariable
    }
}
