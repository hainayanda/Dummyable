//
//  StructInitFuncPeerFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

struct StructInitFuncPeerFactory: DeclBuilder {
    
    private let dummyFuncDeclFactory: DummyInitFuncDeclFactory
    
    @inlinable init(structDecl: StructDeclSyntax) {
        self.dummyFuncDeclFactory = DummyInitFuncDeclFactory(
            typeExtraction: StructDeclExtraction(source: structDecl)
        )
    }
    
    @inlinable func buildDecl() -> DeclSyntax? {
        DeclSyntax(dummyFuncDeclFactory.buildDummyFuncDecl())
    }
}
