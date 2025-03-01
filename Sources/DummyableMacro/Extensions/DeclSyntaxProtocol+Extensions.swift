//
//  DeclGroupSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

extension DeclSyntaxProtocol {
    @inlinable
    var canBeAttachedWithDummyMacro: Bool {
        self.is(ClassDeclSyntax.self)
        || self.is(StructDeclSyntax.self)
        || self.is(ProtocolDeclSyntax.self)
        || self.is(EnumDeclSyntax.self)
    }
    
    @inlinable
    var canBeAttachedWithDummyableInitMacro: Bool {
        self.is(InitializerDeclSyntax.self)
    }
}
