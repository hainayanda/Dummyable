//
//  ClassInitFuncPeerFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

struct ClassInitFuncPeerFactory: DeclBuilder {
    
    private let dummyFuncDeclFactory: DummyInitFuncDeclFactory
    
    @inlinable init(classDecl: ClassDeclSyntax) throws{
        self.dummyFuncDeclFactory = DummyInitFuncDeclFactory(
            typeExtraction: try ClassDeclExtraction(source: classDecl)
        )
    }
    
    @inlinable func buildDecl() -> DeclSyntax? {
        DeclSyntax(dummyFuncDeclFactory.buildDummyFuncDecl())
    }
}

