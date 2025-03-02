//
//  DummyFuncFromProtocolDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummyFuncFromProtocolDeclFactory: DummyFuncCallExprBuilder {
    
    let modifiers: DeclModifierListSyntax
    let baseFunc: FunctionDeclSyntax
    
    @inlinable func buildFuncDecl() -> FunctionDeclSyntax {
        var modifiedFunc = baseFunc
        modifiedFunc.modifiers = modifiers
        modifiedFunc.body = CodeBlockSyntax {
            buildDummyFuncCallExpr(forType: baseFunc.signature.returnClause?.type)
        }
        return modifiedFunc
    }
}
