//
//  FreestandingDummyDeclarationFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct FreestandingDummyDeclarationFactory {
    let staticMacroFactory: DummiesClosureStaticFuncDeclFactory
    
    init(extraction: FreestandingMacroExtraction) {
        self.staticMacroFactory = DummiesClosureStaticFuncDeclFactory(
            modifiers: extraction.modifiers,
            returnType: IdentifierTypeSyntax(name: extraction.type.baseName),
            closure: extraction.closure
        )
    }
    
    func buildDecl() throws -> [DeclSyntax] {
        [
            DeclSyntax(
                staticMacroFactory.buildDummyFuncDecl()
            )
        ]
    }
}
