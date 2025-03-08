//
//  DummyClosuresFuncDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 05/03/25.
//

import SwiftSyntax

struct DummyClosuresFuncDeclFactory: ArrayDeclBuilder {
    typealias ClosureType = DummyClosureFuncDeclFactory.ClosureType
    typealias ClosureTypeCreation = DummyClosureFuncDeclFactory.ClosureTypeCreation
    
    let closureFuncDeclFactory: [DummyClosureFuncDeclFactory]
    
    @inlinable init(attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax,
         genericParameters: GenericParameterListSyntax? = nil, returnType: IdentifierTypeSyntax,
         genericWhereClause: GenericWhereClauseSyntax? = nil, creationType: ClosureTypeCreation) {
        closureFuncDeclFactory = [
            ClosureType.noArg, ClosureType.oneArg,
            ClosureType.twoArgs, ClosureType.threeArgs,
            ClosureType.fourArgs
        ].map { closureType in
            DummyClosureFuncDeclFactory(
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
