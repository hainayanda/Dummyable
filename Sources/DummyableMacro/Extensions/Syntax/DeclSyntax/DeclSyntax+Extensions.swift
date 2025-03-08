//
//  DeclSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

// MARK: DeclSyntax

extension DeclSyntax {
    @inlinable func inArray() -> [DeclSyntax] {
        [self]
    }
}

// MARK: DeclSyntaxProtocol

extension DeclSyntaxProtocol {
    
    @inlinable var canBeAttachedWithDummyableInitMacro: Bool {
        self.is(InitializerDeclSyntax.self)
    }
    
    @inlinable var canBeAttachedWithDummyableCaseMacro: Bool {
        self.is(EnumCaseDeclSyntax.self)
    }
}