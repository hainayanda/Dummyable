//
//  EnumCaseDeclSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

extension EnumCaseDeclSyntax {
    @inlinable var hasDummyableCaseAttribute: Bool {
        attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .compactMap { $0.attributeName.as(IdentifierTypeSyntax.self) }
            .contains { $0.name.trimmedDescription == "DummyableCase" }
    }
}
