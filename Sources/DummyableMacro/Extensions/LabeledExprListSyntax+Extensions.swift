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
                    expr: labeledExpr.expression
                )
            }
    }
    
    var labeledWithModifier: DeclModifierSyntax? {
        let description = enumerated().first {
            $0.element.label?.trimmedDescription == "modifier"
            && $0.offset == 1
        }?.element.expression.trimmedDescription
        
        switch description {
        case ".public", "DummyModifier.public", "Dummyable.DummyModifier.public",
            ".`public`", "DummyModifier.`public`", "Dummyable.DummyModifier.`public`" :
            return DeclModifierSyntax.public
        case ".private", "DummyModifier.private", "Dummyable.DummyModifier.private",
            ".`private`", "DummyModifier.`private`", "Dummyable.DummyModifier.`private`":
            return DeclModifierSyntax.private
        case ".fileprivate", "DummyModifier.fileprivate", "Dummyable.DummyModifier.fileprivate",
            ".`fileprivate`", "DummyModifier.`fileprivate`", "Dummyable.DummyModifier.`fileprivate`":
            return DeclModifierSyntax.fileprivate
        default:
            return nil
        }
    }
}
