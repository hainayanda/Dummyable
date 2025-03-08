//
//  GenericArgumentClauseSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 08/03/25.
//

import SwiftSyntax

extension GenericArgumentClauseSyntax {
    
    typealias DTS = DummyableTokenSyntaxes
    
    func replaceWithDefault(at indexes: [Int]) -> GenericArgumentClauseSyntax {
        var replaced = self
        replaced.arguments = GenericArgumentListSyntax {
            for (index, argument) in self.arguments.enumerated() {
                if indexes.contains(index) {
                    GenericArgumentSyntax(
                        argument: IdentifierTypeSyntax(name: DTS.genericTypes[index])
                    )
                } else {
                    argument
                }
            }
        }
        return replaced
    }
}
