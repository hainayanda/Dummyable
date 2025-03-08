//
//  DeclGroupSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

extension DeclGroupSyntax {
    @inlinable var canBeAttachedWithDummyMacro: Bool {
        self.is(ClassDeclSyntax.self)
        || self.is(StructDeclSyntax.self)
        || self.is(ProtocolDeclSyntax.self)
        || self.is(EnumDeclSyntax.self)
    }
}
