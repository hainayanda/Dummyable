//
//  File.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

extension ExtensionDeclSyntax {
    func inArray() -> [ExtensionDeclSyntax] {
        [self]
    }
}

extension Optional where Wrapped == ExtensionDeclSyntax {
    func inArray() -> [ExtensionDeclSyntax] {
        guard let value = self else {
            return []
        }
        return [value]
    }
}
