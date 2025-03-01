//
//  DummyableOnProtocolDummiesFuncDeclFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

struct DummyableOnProtocolDummiesFuncDeclFactory {

    // periphery:ignore
    let extraction: ProtocolDeclExtraction
    let staticFuncFactory: DummiesStaticFuncDeclFactory
    
    init(extraction: ProtocolDeclExtraction) {
        self.extraction = extraction
        self.staticFuncFactory = DummiesStaticFuncDeclFactory(
            protocolExtraction: extraction
        )
    }
    
    func buildExtDecl() -> ExtensionDeclSyntax {
        staticFuncFactory.buildDummyFuncDecl()
    }
}
