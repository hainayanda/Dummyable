//
//  VariableDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

extension VariableDeclSyntax {
    
    typealias DTS = DummyableTokenSyntaxes
    
    var shouldBeAssignedFromInit: Bool {
        guard let binding = self.bindings.first, binding.initializer == nil, !hasGetter else {
            return false
        }
        return true
    }
    
    var hasGetter: Bool {
        guard let accessors = bindings.first?.accessorBlock?.accessors.as(AccessorDeclListSyntax.self) else {
            return false
        }
        guard !accessors.isEmpty else {
            return true
        }
        return accessors.contains(where: { $0.accessorSpecifier.text == DTS.get.text })
    }
    
    var extraction: VariableDeclExtraction? {
        bindings.compactMap { binding -> VariableDeclExtraction? in
            guard let identifierPattern = binding.pattern.as(IdentifierPatternSyntax.self)?.trimmed,
                  let type = binding.typeAnnotation else {
                return nil
            }
            return VariableDeclExtraction(
                name: identifierPattern,
                typeAnotation: type
            )
        }
        .first
    }
}

extension Sequence where Element == VariableDeclSyntax {
    func extractions() -> [VariableDeclExtraction] {
        compactMap { $0.extraction }
    }
}

struct VariableDeclExtraction {
    let name: IdentifierPatternSyntax
    let typeAnotation: TypeAnnotationSyntax
}

struct ParameterDeclExtraction {
    let name: TokenSyntax?
    let type: TypeSyntax
}
