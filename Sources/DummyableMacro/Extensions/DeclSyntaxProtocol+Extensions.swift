//
//  DeclGroupSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

extension DeclSyntaxProtocol {
    
    @inlinable var canBeAttachedWithDummyableInitMacro: Bool {
        self.is(InitializerDeclSyntax.self)
    }
    
    @inlinable var canBeAttachedWithDummyableCaseMacro: Bool {
        self.is(EnumCaseDeclSyntax.self)
    }
}
