//
//  DummiesClosureStaticFuncDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummiesClosureStaticFuncDeclFactory {
    
    let baseFactory: DummiesStaticFuncDeclFactory
    let closure: ClosureExprSyntax
    
    init(modifiers: DeclModifierListSyntax, returnType: IdentifierTypeSyntax, closure: ClosureExprSyntax) {
        self.baseFactory = DummiesStaticFuncDeclFactory(
            attributes: [],
            modifiers: modifiers,
            returnType: returnType
        )
        self.closure = closure
    }
    
    func buildDummyFuncDecl() -> ExtensionDeclSyntax {
        baseFactory.buildDummyFuncDecl {
            closure.statements
        }
    }
}
