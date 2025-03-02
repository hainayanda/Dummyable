//
//  DeclSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

extension DeclSyntax {
    @inlinable func inArray() -> [DeclSyntax] {
        [self]
    }
}

// MARK: Optional<DeclSyntax>

extension Optional where Wrapped == DeclSyntax {
    @inlinable func inArray() -> [DeclSyntax] {
        guard let self = self else { return [] }
        return self.inArray()
    }
}
