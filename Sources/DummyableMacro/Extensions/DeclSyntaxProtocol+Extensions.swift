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
    
    @inlinable
    var typeDeclName: TokenSyntax? {
        if let classDecl = self.as(ClassDeclSyntax.self) {
            return classDecl.name
        } else if let structDecl = self.as(StructDeclSyntax.self) {
            return structDecl.name
        } else if let protocolDecl = self.as(ProtocolDeclSyntax.self) {
            return protocolDecl.typeDeclName
        }
        else {
            return nil
        }
    }
}
