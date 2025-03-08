//
//  FreestandingMacroExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct FreestandingMacroExtraction {
    let modifiers: DeclModifierListSyntax
    let type: IdentifierTypeSyntax
    let closure: ClosureExprSyntax
    let metaDatas: [FreestandingMetaData]
    
    @inlinable init(from node: FreestandingMacroExpansionSyntax) throws {
        
        guard let expression = node.argumentList.first?.expression.as(MemberAccessExprSyntax.self)?.base,
              let closure = node.lastClosure else {
            throw DummyableMacroError.wrongArguments
        }
        
        self.closure = closure
        
        self.metaDatas = node.argumentList.dropFirst()
            .compactMap { FreestandingMetaData(from: $0) }
            .compacted()
        
        self.type = expression.identifierTypeSyntax(metaDatas: metaDatas)
        
        self.modifiers = switch node.macro.trimmedDescription {
        case "PublicDummy", "Dummyable.PublicDummy": [.public]
        case "PrivateDummy", "Dummyable.PrivateDummy": [.private]
        default: []
        }
    }
}

// MARK: DummyFuncForClosureDeclFactory + Extensions

extension DummyFuncForClosuresDeclFactory {
    @inlinable init(freestandingExtraction: FreestandingMacroExtraction) throws {
        self.init(
            attributes: freestandingExtraction.metaDatas.attributes ?? [],
            modifiers: freestandingExtraction.modifiers,
            genericParameters: freestandingExtraction.metaDatas.genericParameters,
            returnType: freestandingExtraction.type,
            genericWhereClause: freestandingExtraction.metaDatas.genericWhereClauses,
            creationType: .codeBlock(freestandingExtraction.closure.statements.trimmed)
        )
    }
}

// MARK: DummiesFuncDeclFactory + Extensions

extension DummyFuncForArrayDeclFactory {
    @inlinable init(freestandingExtraction: FreestandingMacroExtraction) throws {
        self.init(
            attributes: freestandingExtraction.metaDatas.attributes ?? [],
            modifiers: freestandingExtraction.modifiers,
            genericParameters: freestandingExtraction.metaDatas.genericParameters,
            elementType: freestandingExtraction.type,
            genericWhereClause: freestandingExtraction.metaDatas.genericWhereClauses,
            creationType: .codeBlock(freestandingExtraction.closure.statements.trimmed)
        )
    }
}
