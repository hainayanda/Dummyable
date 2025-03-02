//
//  InitMemberwiseParam.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

@usableFromInline
struct InitMemberwiseParam {
    let raw: FunctionParameterSyntax
    let destination: TokenSyntax
    
    var parameterName: TokenSyntax {
        raw.firstName
    }
    
    var type: TypeSyntax {
        raw.type
    }
}
