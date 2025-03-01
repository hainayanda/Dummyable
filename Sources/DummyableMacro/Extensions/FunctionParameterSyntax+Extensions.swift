//
//  File.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

extension FunctionParameterSyntax {
    func withDefaultValue(_ value: InitializerClauseSyntax) -> FunctionParameterSyntax {
        return FunctionParameterSyntax(
            firstName: firstName,
            secondName: secondName,
            type: type,
            defaultValue: value
        )
    }
}
