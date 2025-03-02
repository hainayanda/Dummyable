//
//  DummyFuncFromProtocolDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummyFuncFromProtocolDeclFactory: DummyFuncCallExprBuilder {
    
    private let modifiers: DeclModifierListSyntax
    private let baseFunc: FunctionDeclSyntax
    
    @inlinable init(modifiers: DeclModifierListSyntax, baseFunc: FunctionDeclSyntax) {
        self.modifiers = modifiers
        self.baseFunc = baseFunc
    }
    
    @inlinable func buildFuncDecl() -> FunctionDeclSyntax {
        var modifiedFunc = baseFunc
        modifiedFunc.modifiers = modifiers
        modifiedFunc.body = CodeBlockSyntax {
            buildDummyFuncCallExpr(forType: baseFunc.signature.returnClause?.type)
        }
        return modifiedFunc
    }
}
