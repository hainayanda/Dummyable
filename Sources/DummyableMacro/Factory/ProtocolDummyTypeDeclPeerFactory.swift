//
//  ProtocolDummyTypeDeclPeerFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

struct ProtocolDummyTypeDeclPeerFactory: DeclBuilder, DummyFuncCallExprBuilder {
    
    private let extraction: ProtocolDeclExtraction
    
    @inlinable init(protocolDecl: ProtocolDeclSyntax, node: AttributeSyntax) {
        self.extraction = ProtocolDeclExtraction(source: protocolDecl, attribute: node)
    }
    
    @inlinable func buildDecl() throws -> DeclSyntax? {
        return switch try extraction.generationType {
        case .class:
            try DummyTypeDeclFactory(
                modifiers: [.final, .private],
                extraction: extraction,
                for: ClassDeclSyntax.self
            )
            .buildDecl()
        case .struct:
            try DummyTypeDeclFactory(
                modifiers: [.private],
                extraction: extraction,
                for: StructDeclSyntax.self
            )
            .buildDecl()
        }
    }
}
