//
//  ProtocolConcreteInitDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

struct ProtocolConcreteInitDeclFactory: DummyFuncCallExprBuilder {
    
    private let modifiers: DeclModifierListSyntax
    private let baseInit: InitializerDeclSyntax
    
    @inlinable init(
        modifiers: DeclModifierListSyntax,
        baseInit: InitializerDeclSyntax) {
            self.modifiers = modifiers
            self.baseInit = baseInit
        }
    
    @inlinable func buildInitDecl() -> InitializerDeclSyntax {
        var modifiedInit = baseInit
        modifiedInit.modifiers = modifiers
        modifiedInit.body = CodeBlockSyntax(statements: [])
        return modifiedInit.trimmed
    }
}
