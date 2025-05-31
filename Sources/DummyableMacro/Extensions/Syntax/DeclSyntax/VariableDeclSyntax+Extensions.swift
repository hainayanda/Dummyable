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
        guard let binding = self.bindings.first, binding.initializer == nil, !hasGetter, !isComputedProperty else {
            return false
        }
        return true
    }
    
    var accessors: AccessorDeclListSyntax? {
        guard let accessors = bindings.first?.accessorBlock?.accessors.as(AccessorDeclListSyntax.self) else {
            return nil
        }
        guard !accessors.isEmpty else {
            return nil
        }
        return accessors
    }
    
    var hasGetter: Bool {
        accessors?.contains { $0.accessorSpecifier.text == DTS.get.text } ?? false
    }
    
    var hasSetter: Bool {
        accessors?.contains { $0.accessorSpecifier.text == DTS.set.text } ?? false
    }
    
    var isComputedProperty: Bool {
        guard let accessorsBlock = bindings.first?.accessorBlock else {
            return false
        }
        guard let accessors = accessorsBlock.accessors.as(AccessorDeclListSyntax.self) else {
            return true
        }
        return accessors.contains { accessor in
            let text = accessor.accessorSpecifier.text
            return text == DTS.get.text
        }
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
}


