//
//  DummyFuncForClosuresDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 05/03/25.
//

import SwiftSyntax

struct DummyFuncForClosuresDeclFactory: ArrayDeclBuilder {
    typealias ClosureType = DummyFuncForClosureDeclFactory.ClosureType
    
    let closureFuncDeclFactory: [DummyFuncForClosureDeclFactory]
    
    @inlinable init(
        attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax,
        genericParameters: GenericParameterListSyntax?, returnType: TypeSyntaxProtocol,
        genericWhereClause: GenericWhereClauseSyntax?, creationType: DummyCreationType) {
            closureFuncDeclFactory = [
                ClosureType.noArg, ClosureType.oneArg,
                ClosureType.twoArgs, ClosureType.threeArgs,
                ClosureType.fourArgs
            ].map { closureType in
                DummyFuncForClosureDeclFactory(
                    closureType: closureType,
                    attributes: attributes,
                    modifiers: modifiers,
                    genericParameters: genericParameters,
                    returnType: returnType,
                    genericWhereClause: genericWhereClause,
                    creationType: creationType
                )
            }
        }
    
    @inlinable func buildDecls() -> [DeclSyntax] {
        closureFuncDeclFactory.compactMap { factory in
            factory.buildDecl()
        }
    }
}
