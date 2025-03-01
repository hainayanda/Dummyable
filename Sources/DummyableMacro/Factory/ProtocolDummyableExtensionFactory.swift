//
//  ProtocolDummyableExtensionFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

struct ProtocolDummyableExtensionFactory {

    // periphery:ignore
    let extraction: ProtocolDeclExtraction
    let staticFuncFactory: DummiesInitStaticFuncDeclFactory
    
    init(extraction: ProtocolDeclExtraction) {
        self.extraction = extraction
        self.staticFuncFactory = DummiesInitStaticFuncDeclFactory(
            protocolExtraction: extraction
        )
    }
    
    func buildExtDecl() -> [ExtensionDeclSyntax] {
        staticFuncFactory
            .buildDummyFuncDecl()
            .inArray()
    }
}
