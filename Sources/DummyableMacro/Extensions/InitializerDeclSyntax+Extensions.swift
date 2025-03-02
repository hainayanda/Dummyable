//
//  InitializerDeclSyntax.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

extension InitializerDeclSyntax {
    
    @inlinable static var baseVoidInit: InitializerDeclSyntax {
        InitializerDeclSyntax(
            signature: FunctionSignatureSyntax(
                parameterClause: FunctionParameterClauseSyntax(parameters: [])
            )
        )
    }
    
    @inlinable var hasDummyableInitAttribute: Bool {
        attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .compactMap { $0.attributeName.as(IdentifierTypeSyntax.self) }
            .contains { $0.name.trimmedDescription == "DummyableInit" }
    }
    
    @inlinable var canBeUsedAsDummyableInit: Bool {
        !modifiers.contains { $0.trimmedDescription == "private" }
        && genericWhereClause == nil
        && genericParameterClause == nil
        && optionalMark == nil
        && signature.effectSpecifiers == nil
    }
    
    func argumentMatched(with variables: [VariableDeclSyntax]) -> Bool {
        let parameters = signature.parameterClause.parameters
        guard parameters.count == variables.count else {
            return false
        }
        for (index, parameter) in parameters.enumerated() {
            guard let extraction = variables[index].extraction,
                  parameter.firstName.trimmedDescription == extraction.name.trimmedDescription ,
                  parameter.type.trimmedDescription == extraction.typeAnotation.type.trimmedDescription else {
                return false
            }
            continue
        }
        return true
    }
    
    func asInitializerParameters() -> [InitializerParameter] {
        signature.parameterClause.parameters
            .filter { $0.defaultValue == nil }
            .compactMap {
                InitializerParameter(
                    name: $0.firstName.trimmed,
                    type: $0.type.trimmed
                )
                
            }
    }
    
    @inlinable func isSimilar(with other: InitializerDeclSyntax) -> Bool {
        return self.optionalMark?.trimmedDescription == other.optionalMark?.trimmedDescription
        && self.genericParameterClause?.trimmedDescription == other.genericParameterClause?.trimmedDescription
        && self.signature.trimmedDescription == other.signature.trimmedDescription
        && self.genericWhereClause?.trimmedDescription == other.genericWhereClause?.trimmedDescription
    }
}

// MARK: Sequence of InitializerDeclSyntax

extension Sequence where Element == InitializerDeclSyntax {
    @inlinable func withDummyableInitAttribute() -> [InitializerDeclSyntax] {
        filter { $0.hasDummyableInitAttribute && $0.canBeUsedAsDummyableInit }
    }
}
