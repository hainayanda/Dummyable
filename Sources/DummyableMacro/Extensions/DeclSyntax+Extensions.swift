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
