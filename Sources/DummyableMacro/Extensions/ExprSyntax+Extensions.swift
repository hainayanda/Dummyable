//
//  ExprSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

extension ExprSyntax {
    var selfTypeAccessName: ExprSyntax? {
        guard trimmedDescription.match(#"^\S+\.self$"#),
              let memberAccessExpr = self.as(MemberAccessExprSyntax.self),
              let base = memberAccessExpr.base else {
            return nil
        }
        return base
    }
}
