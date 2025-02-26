//
//  StructDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

struct StructDeclExtraction: TypeDeclExtracting {
    
    typealias DTS = DummyableTokenSyntaxes
    
    let source: StructDeclSyntax
    let attribute: AttributeSyntax
    
    @inlinable
    var declName: TokenSyntax {
        source.name
    }
    
    @inlinable
    var availableAttributes: [AttributeListSyntax.Element] {
        source.attributes
            .compactMap { $0.as(AttributeSyntax.self) }
            .filter { $0.is(.available) }
            .map { .attribute($0) }
    }
    
    @inlinable
    var modifiers: DeclModifierListSyntax {
        source.modifiers.noLessThanInternal()
    }
    
    let variablesNeededForInit: [VariableDeclSyntax]
    let usableInitDecl: InitializerDeclSyntax?
    
    init(source: StructDeclSyntax, attribute: AttributeSyntax) {
        self.source = source
        self.attribute = attribute
        self.usableInitDecl = source.initDeclMarkedWithDummyableInitAttr ?? source.initDeclWithMandatoryParameters
        self.variablesNeededForInit = if usableInitDecl == nil {
            source.mandatoryVariables
        } else {
            []
        }
    }
}
