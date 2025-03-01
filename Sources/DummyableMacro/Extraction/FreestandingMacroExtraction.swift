//
//  FreestandingMacroExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct FreestandingMacroExtraction {
    let modifier: DeclModifierSyntax?
    let type: DeclReferenceExprSyntax
    let closure: ClosureExprSyntax
    
    var modifiers: DeclModifierListSyntax {
        guard let modifier = modifier else {
            return []
        }
        return [modifier]
    }
    
    init(from node: some FreestandingMacroExpansionSyntax) throws {
        guard let expression = node.argumentList.first?.expression.as(MemberAccessExprSyntax.self),
              let type = expression.base?.as(DeclReferenceExprSyntax.self) else {
            throw DummyableMacroError.wrongArguments
        }
        self.type = type
        self.closure = if let trailingClosure = node.trailingClosure {
            trailingClosure
        } else if node.argumentList.count >= 2, let closure = node.argumentList.last?.expression.as(ClosureExprSyntax.self) {
            closure
        } else {
            throw DummyableMacroError.wrongArguments
        }
        self.modifier = node.argumentList.labeledWithModifier
    }
}
