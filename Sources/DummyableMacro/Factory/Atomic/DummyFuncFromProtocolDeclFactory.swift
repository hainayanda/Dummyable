//
//  DummyFuncFromProtocolDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummyFuncFromProtocolDeclFactory: DummyFuncCallCodeBuilder {
    
    let modifiers: DeclModifierListSyntax
    let baseFunc: FunctionDeclSyntax
    
    func buildFuncDecl() -> FunctionDeclSyntax {
        var modifiedFunc = baseFunc
        modifiedFunc.modifiers = modifiers
        modifiedFunc.body = CodeBlockSyntax {
            buildDummyFunctionCallExpr(forType: baseFunc.signature.returnClause?.type)
        }
        return modifiedFunc
    }
}
