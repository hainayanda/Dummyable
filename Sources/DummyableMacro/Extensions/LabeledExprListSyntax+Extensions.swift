//
//  LabeledExprListSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

extension LabeledExprListSyntax {
    func labeled(by label: TokenSyntax?) -> [ArgumentExpression]? {
        return enumerated()
            .filter { _, labeledExpr in
                labeledExpr.label?.text == label?.text
            }
            .map { offset, labeledExpr in
                ArgumentExpression(
                    offset: offset,
                    label: labeledExpr.label,
                    expr: labeledExpr.expression
                )
            }
    }
}
