//
//  FreestandingDummyDeclarationFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct FreestandingDummyDeclarationFactory {
    let extraction: FreestandingMacroExtraction
    let staticMacroFactory: StaticDummyFuncDeclFactory
    
    init(extraction: FreestandingMacroExtraction) {
        self.extraction = extraction
        self.staticMacroFactory = StaticDummyFuncDeclFactory(
            returnType: IdentifierTypeSyntax(name: extraction.type.baseName)
        )
    }
    
    func buildDecl() throws -> [DeclSyntax] {
        [
            DeclSyntax(
                staticMacroFactory.buildDummyFuncDecl {
                    extraction.closure.statements.trimmed
                }
            )
        ]
    }
}
