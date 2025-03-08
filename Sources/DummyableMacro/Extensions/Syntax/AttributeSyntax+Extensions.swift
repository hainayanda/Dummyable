//
//  AttributeSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

extension AttributeSyntax {
    typealias DTS = DummyableTokenSyntaxes
    
    @inlinable func `is`(_ name: AttributeName) -> Bool {
        name.applicableAttributes.contains(attributeName.trimmedDescription)
    }
    
    var typeArgumentGenerationType: ProtocolConcreteType? {
        get throws {
            guard let expr = try typeArgumentExpr else {
                return nil
            }
            guard let memberExpr = expr.as(MemberAccessExprSyntax.self) else {
                throw DummyableMacroError.wrongArguments
            }
            return try extractTypeArgumentGenerationType(from: memberExpr)
        }
    }
    
    private var typeArgumentExpr: ExprSyntax? {
        get throws {
            guard let argument = arguments?.labeled(by: DTS.type)?.first else {
                return nil
            }
            guard argument.offset == 0 else {
                throw DummyableMacroError.wrongArguments
            }
            return argument.expr
        }
    }
    
    private func extractTypeArgumentGenerationType(from memberExpr: MemberAccessExprSyntax) throws -> ProtocolConcreteType? {
        if memberExpr.trimmedDescription.match(#"^(Dummyable\.)?(DummyType)?\.`?struct`?$"#) {
            return .struct
        } else if memberExpr.trimmedDescription.match(#"^(Dummyable\.)?(DummyType)?\.`?class`?$"#) {
            return .class
        } else {
            throw DummyableMacroError.wrongArguments
        }
    }
}

// MARK: AttributeSyntax.Arguments

extension AttributeSyntax.Arguments {
    func labeled(by label: TokenSyntax?) -> [ArgumentExpression]? {
        self.as(LabeledExprListSyntax.self)?.labeled(by: label)
    }
}


