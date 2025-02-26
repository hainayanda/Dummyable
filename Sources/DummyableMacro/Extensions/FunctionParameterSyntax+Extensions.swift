//
//  File.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

extension FunctionParameterSyntax {
    func match(with variable: VariableDeclSyntax) -> Bool {
        guard let extraction = variable.extraction else {
            return false
        }
        return firstName.trimmedDescription == extraction.name.trimmedDescription
        && type.trimmedDescription == extraction.typeAnotation.type.trimmedDescription
    }
}
