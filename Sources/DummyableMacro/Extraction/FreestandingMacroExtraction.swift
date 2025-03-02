//
//  FreestandingMacroExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct FreestandingMacroExtraction {
    let modifiers: DeclModifierListSyntax
    let type: DeclReferenceExprSyntax
    let closure: ClosureExprSyntax
    
    @inlinable init(from node: FreestandingMacroExpansionSyntax) throws {
        guard let expression = node.argumentList.first?.expression.as(MemberAccessExprSyntax.self),
              let type = expression.base?.as(DeclReferenceExprSyntax.self) else {
            throw DummyableMacroError.wrongArguments
        }
        
        self.type = type.trimmed
        
        self.closure = if let trailingClosure = node.trailingClosure {
            trailingClosure.trimmed
        } else if node.argumentList.count == 2, let closure = node.argumentList.last?.expression.as(ClosureExprSyntax.self) {
            closure.trimmed
        } else {
            throw DummyableMacroError.wrongArguments
        }
        
        self.modifiers = switch node.macro.trimmedDescription {
        case "PublicDummy", "Dummyable.PublicDummy": [.public]
        case "PrivateDummy", "Dummyable.PrivateDummy": [.private]
        default: []
        }
    }
}
