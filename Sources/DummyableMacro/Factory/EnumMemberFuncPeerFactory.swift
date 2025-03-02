//
//  EnumMemberFuncPeerFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct EnumMemberFuncPeerFactory: DeclBuilder {

    let dummyFuncDeclFactory: DummyEnumFuncDeclFactory
    
    @inlinable init(enumDecl: EnumDeclSyntax) throws {
        self.dummyFuncDeclFactory = DummyEnumFuncDeclFactory(
            extraction: try EnumDeclExtraction(source: enumDecl)
        )
    }
    
    @inlinable func buildDecl() -> DeclSyntax? {
        DeclSyntax(dummyFuncDeclFactory.buildDummyFuncDecl())
    }
}
