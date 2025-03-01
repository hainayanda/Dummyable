//
//  EnumDummyableExtensionFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct EnumDummyableExtensionFactory {

    // periphery:ignore
    let extraction: EnumDeclExtraction
    let staticFuncFactory: DummiesEnumStaticFuncDeclFactory
    
    init(extraction: EnumDeclExtraction) {
        self.extraction = extraction
        self.staticFuncFactory = DummiesEnumStaticFuncDeclFactory(extraction: extraction)
    }
    
    func buildExtDecl() -> [ExtensionDeclSyntax] {
        staticFuncFactory
            .buildDummyFuncDecl()
            .inArray()
    }
}
