//
//  ArgumentExpression.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

@usableFromInline
struct ArgumentExpression {
    let offset: Int
    let expr: ExprSyntax
}
