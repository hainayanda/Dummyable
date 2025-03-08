//
//  FreestandingMacroExpansionsSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 08/03/25.
//

import SwiftSyntax

extension FreestandingMacroExpansionSyntax {
    @inlinable var lastClosure: ClosureExprSyntax? {
        if let trailingClosure {
            trailingClosure.trimmed
        } else if argumentList.count >= 2, let closure = argumentList.last?.expression.as(ClosureExprSyntax.self) {
            closure.trimmed
        } else {
            nil
        }
    }
}
