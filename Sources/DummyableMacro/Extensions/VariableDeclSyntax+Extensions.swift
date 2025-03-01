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
    
    var asInitializerDirectParameter: InitializerDirectParameter? {
        bindings.compactMap { binding -> FunctionParameterSyntax? in
            guard let identifierPattern = binding.pattern.as(IdentifierPatternSyntax.self)?.trimmed,
                  let type = binding.typeAnnotation?.type else {
                return nil
            }
            return FunctionParameterSyntax(
                firstName: identifierPattern.identifier.trimmed,
                type: type
            )
        }
        .map {
            InitializerDirectParameter(
                raw: $0,
                destination: $0.firstName
            )
        }
        .first
    }
}

extension Sequence where Element == VariableDeclSyntax {
    
    func asInitializerDirectParameters() -> [InitializerDirectParameter] {
        compactMap { $0.asInitializerDirectParameter }
    }
}

struct InitializerDirectParameter {
    let raw: FunctionParameterSyntax
    let destination: TokenSyntax
    
    var parameterName: TokenSyntax {
        raw.firstName
    }
    
    var type: TypeSyntax {
        raw.type
    }
}

struct VariableDeclExtraction {
    let name: IdentifierPatternSyntax
    let typeAnotation: TypeAnnotationSyntax
}