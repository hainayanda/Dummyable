//
//  StructDummyableExtensionFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

struct StructDummyableExtensionFactory {

    // periphery:ignore
    let extraction: StructDeclExtraction
    let staticFuncDeclFactory: DummiesInitStaticFuncDeclFactory
    
    init(extraction: StructDeclExtraction) {
        self.extraction = extraction
        self.staticFuncDeclFactory = DummiesInitStaticFuncDeclFactory(
            typeExtraction: extraction
        )
    }
    
    func buildExtDecl() -> [ExtensionDeclSyntax] {
        staticFuncDeclFactory
            .buildDummyFuncDecl()
            .inArray()
    }
}
