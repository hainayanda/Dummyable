//
//  DummyGenerationType.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//


import SwiftSyntax

enum DummyGenerationType {
    case `class`
    case `struct`
    
    func validate(isObjectProtocol: Bool) throws {
        guard isObjectProtocol else { return }
        switch self {
        case .class:
            break
        default:
            throw DummyableMacroError.wrongArguments
        }
    }
}
