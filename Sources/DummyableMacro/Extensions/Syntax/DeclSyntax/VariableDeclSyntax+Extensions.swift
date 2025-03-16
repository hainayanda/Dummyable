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
    
    var hasSetter: Bool {
        guard let accessors = bindings.first?.accessorBlock?.accessors.as(AccessorDeclListSyntax.self) else {
            return false
        }
        guard !accessors.isEmpty else {
            return true
        }
        return accessors.contains(where: { $0.accessorSpecifier.text == DTS.set.text })
    }
    
    var extraction: VariableDeclExtraction? {
        VariableDeclExtraction(variable: self)
    }
    
    var asInitMemberwiseParam: InitMemberwiseParam? {
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
            InitMemberwiseParam(
                raw: $0,
                destination: $0.firstName
            )
        }
        .first
    }
}

// MARK: Sequence of VariableDeclSyntax

extension Sequence where Element == VariableDeclSyntax {
    
    func asInitMemberwiseParam() -> [InitMemberwiseParam] {
        compactMap { $0.asInitMemberwiseParam }
    }
    
    func extracts() -> [VariableDeclExtraction] {
        compactMap { $0.extraction }
    }
}


