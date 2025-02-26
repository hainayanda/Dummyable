//
//  ArgumentExpression.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

struct ArgumentExpression {
    let offset: Int
    let label: TokenSyntax?
    let expr: ExprSyntax
}
