//
//  ClassDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

struct ClassDeclExtraction: TypeDeclExtraction {
    
    let source: ClassDeclSyntax
    var sourceDecl: TypeDeclSyntax { source }
    
    @inlinable
    var modifiers: DeclModifierListSyntax {
        source.modifiers.onlyAccessModifier().trimmed
    }
    
    let usableInitDecl: InitializerDeclSyntax?
    
    init(source: ClassDeclSyntax) throws {
        self.source = source
        guard let initDecl = source.initDeclMarkedWithDummyableInitAttr else {
            throw DummyableMacroError.dummyNeedDummyableInit
        }
        self.usableInitDecl = initDecl
    }
}
