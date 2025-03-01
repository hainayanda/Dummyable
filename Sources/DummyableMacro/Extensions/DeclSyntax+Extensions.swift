//
//  DeclSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

extension DeclSyntax {
    func inArray() -> [DeclSyntax] {
        [self]
    }
}

extension Optional where Wrapped == DeclSyntax {
    func inArray() -> [DeclSyntax] {
        guard let self = self else { return [] }
        return [self]
    }
}
