//
//  DummyOnStructFuncDeclMacroFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

struct DummyOnStructFuncDeclMacroFactory {

    // periphery:ignore
    let extraction: StructDeclExtraction
    let staticFuncDeclFactory: DummiesStaticFuncDeclFactory
    
    init(extraction: StructDeclExtraction) {
        self.extraction = extraction
        self.staticFuncDeclFactory = DummiesStaticFuncDeclFactory(
            typeExtraction: extraction
        )
    }
    
    func expandExtensionCodeGeneration() -> ExtensionDeclSyntax? {
        staticFuncDeclFactory.buildDummyFuncDecl()
    }
}
