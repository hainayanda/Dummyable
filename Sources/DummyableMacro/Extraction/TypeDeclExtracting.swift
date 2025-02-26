//
//  TypeDeclExtracting.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 26/02/25.
//

import SwiftSyntax

protocol TypeDeclExtracting {
    var declName: TokenSyntax { get }
    var availableAttributes: [AttributeListSyntax.Element] { get }
    var modifiers: DeclModifierListSyntax { get }
    var variablesNeededForInit: [VariableDeclSyntax] { get }
    var usableInitDecl: InitializerDeclSyntax? { get }
}
