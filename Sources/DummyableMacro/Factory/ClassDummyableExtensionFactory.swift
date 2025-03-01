//
//  ClassDummyableExtensionFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

struct ClassDummyableExtensionFactory {

    // periphery:ignore
    let extraction: ClassDeclExtraction
    let staticFuncDeclFactory: DummiesInitStaticFuncDeclFactory
    
    init(extraction: ClassDeclExtraction) {
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

