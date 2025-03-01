//
//  EnumCaseElementSyntax.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

extension EnumCaseElementSyntax {
    var parameterCount: Int {
        parameterClause?.parameters.count ?? 0
    }
}
