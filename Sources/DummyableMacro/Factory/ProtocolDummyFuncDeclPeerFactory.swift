//
//  ProtocolDummyFuncDeclPeerFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

struct ProtocolDummyFuncDeclPeerFactory: DeclBuilder {

    let dummyFuncDeclFactory: DummyInitFuncDeclFactory
    
    @inlinable init(protocolDecl: ProtocolDeclSyntax, node: AttributeSyntax) {
        self.dummyFuncDeclFactory = DummyInitFuncDeclFactory(
            protocolExtraction: ProtocolDeclExtraction(source: protocolDecl, attribute: node)
        )
    }
    
    @inlinable func buildDecl() -> DeclSyntax? {
        DeclSyntax(dummyFuncDeclFactory.buildDummyFuncDecl())
    }
}
