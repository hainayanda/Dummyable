//
//  Dumm.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct DummiesStaticFuncDeclFactory {
    
    typealias DTS = DummyableTokenSyntaxes
    
    let attributes: AttributeListSyntax
    let modifiers: DeclModifierListSyntax
    let staticFuncFactory: StaticDummyFuncDeclFactory
    
    init(attributes: AttributeListSyntax, modifiers: DeclModifierListSyntax, returnType: IdentifierTypeSyntax) {
        self.attributes = attributes
        self.modifiers = modifiers
        self.staticFuncFactory = StaticDummyFuncDeclFactory(returnType: returnType)
    }
    
    func builDummiesExtDecl(codeBlockBuilder: @escaping () -> CodeBlockItemListSyntax) -> ExtensionDeclSyntax {
        ExtensionDeclSyntax(
            attributes: attributes,
            modifiers: modifiers,
            extendedType: IdentifierTypeSyntax(name: DTS.dummiesType)
        ) {
            MemberBlockItemSyntax(
                decl: staticFuncFactory.buildDummyFuncDecl(codeBlockBuilder: codeBlockBuilder)
            )
        }
    }
}


