//
//  DeclModifierListSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

extension DeclModifierListSyntax {
    
    typealias DTS = DummyableTokenSyntaxes
    
    func noLessThanInternal() -> DeclModifierListSyntax {
        DeclModifierListSyntax {
            self.filter {
                $0.trimmedDescription != "private"
                && $0.trimmedDescription != "fileprivate"
                && $0.trimmedDescription != "internal"
                && $0.trimmedDescription != "final"
            }
        }
    }
    
    func withFinalModifier() -> DeclModifierListSyntax {
        DeclModifierListSyntax {
            DeclModifierSyntax(name: DTS.final)
            self
        }
    }
}
