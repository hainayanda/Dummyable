//
//  DummyOnClassFuncDeclMacroFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

struct DummyOnClassFuncDeclMacroFactory {

    // periphery:ignore
    let extraction: ClassDeclExtraction
    let staticFuncDeclFactory: DummiesStaticFuncDeclFactory
    
    init(extraction: ClassDeclExtraction) {
        self.extraction = extraction
        self.staticFuncDeclFactory = DummiesStaticFuncDeclFactory(
            typeExtraction: extraction
        )
    }
    
    func expandExtensionCodeGeneration() -> ExtensionDeclSyntax? {
        staticFuncDeclFactory.buildDummyFuncDecl()
    }
}

