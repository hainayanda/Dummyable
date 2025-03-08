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

// MARK: Optional<DeclSyntax>

extension Optional where Wrapped == DeclSyntax {
    @inlinable func inArray() -> [DeclSyntax] {
        guard let self = self else { return [] }
        return self.inArray()
    }
}
