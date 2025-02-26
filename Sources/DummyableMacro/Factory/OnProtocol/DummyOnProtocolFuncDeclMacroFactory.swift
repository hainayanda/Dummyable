//
//  DummyOnProtocolFuncDeclMacroFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

struct DummyOnProtocolFuncDeclMacroFactory: ExtDeclSyntaxExpander, DummyFuncDeclCodeBuilder {
    
    typealias DTS = DummyableTokenSyntaxes
    
    let extraction: ProtocolDeclExtraction
    var typeDeclExtraction: TypeDeclExtracting { extraction }
    var dummyFuncParamType: TokenSyntax { extraction.declName }
    var dummyFuncInitType: TokenSyntax { extraction.generationName }
    
    init(extraction: ProtocolDeclExtraction) {
        self.extraction = extraction
    }
    
    func expandExtensionCodeGeneration() throws -> ExtensionDeclSyntax {
        try buildDummyFuncDecl()
    }
}
