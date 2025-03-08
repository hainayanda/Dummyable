//
//  GenericParameterListSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 08/03/25.
//

import SwiftSyntax
import SwiftSyntaxBuilder

extension GenericParameterListSyntax {
    @inlinable var asGenericArgumentClause: GenericArgumentClauseSyntax {
        GenericArgumentClauseSyntax {
            for parameter in self {
                GenericArgumentSyntax(
                    argument: IdentifierTypeSyntax(name: parameter.name.trimmed)
                )
            }
        }
    }
}
