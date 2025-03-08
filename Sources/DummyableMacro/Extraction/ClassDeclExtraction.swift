//
//  ClassDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

struct ClassDeclExtraction: TypeDeclExtraction {
    
    private let source: ClassDeclSyntax
    @inlinable var sourceDecl: TypeDeclSyntax { source }
    
    @inlinable var modifiers: DeclModifierListSyntax {
        source.modifiers.onlyAccessModifier().trimmed
    }
    
    let usableInitDecl: InitializerDeclSyntax?
    
    @inlinable init(source: ClassDeclSyntax) throws {
        self.source = source
        guard let initDecl = source.initDeclMarkedWithDummyableInitAttr else {
            throw DummyableMacroError.dummyNeedDummyableInit
        }
        self.usableInitDecl = initDecl
    }
}

// MARK: DummyClosureFuncDeclFactory + Extensions

extension DummyClosuresFuncDeclFactory {
    @inlinable init(classDecl: ClassDeclSyntax) throws {
        self.init(
            typeExtraction: try ClassDeclExtraction(source: classDecl)
        )
    }
}
