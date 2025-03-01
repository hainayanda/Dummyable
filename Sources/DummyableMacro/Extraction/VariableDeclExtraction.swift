//
//  VariableDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

struct VariableDeclExtraction {
    let name: IdentifierPatternSyntax
    let typeAnotation: TypeAnnotationSyntax
    
    init?(variable: VariableDeclSyntax) {
        let pair = variable.bindings.compactMap { binding -> (IdentifierPatternSyntax, TypeAnnotationSyntax)? in
            guard let identifierPattern = binding.pattern.as(IdentifierPatternSyntax.self)?.trimmed,
                  let type = binding.typeAnnotation else {
                return nil
            }
            return (identifierPattern, type)
        }
        .first
        guard let (name, type) = pair else {
            return nil
        }
        self.name = name
        self.typeAnotation = type
    }
}
