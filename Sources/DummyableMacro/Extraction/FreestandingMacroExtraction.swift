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
    @inlinable init(node: FreestandingMacroExpansionSyntax) throws {
        let extraction = try FreestandingMacroExtraction(from: node)
        self.init(
            attributes: extraction.metaDatas.attributes ?? [],
            modifiers: extraction.modifiers,
            genericParameters: extraction.metaDatas.genericParameters,
            returnType: extraction.type,
            genericWhereClause: extraction.metaDatas.genericWhereClauses,
            creationType: .codeBlock(extraction.closure.statements.trimmed)
        )
    }
}
