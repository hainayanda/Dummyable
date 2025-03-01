//
//  StructDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

struct StructDeclExtraction: TypeDeclExtraction {
    
    let source: StructDeclSyntax
    var sourceDecl: TypeDeclSyntax { source }
    
    let variablesNeededForInit: [VariableDeclSyntax]
    let usableInitDecl: InitializerDeclSyntax?
    
    init(source: StructDeclSyntax) {
        self.source = source
        self.usableInitDecl = source.initDeclMarkedWithDummyableInitAttr ?? source.initDeclWithMandatoryParameters
        self.variablesNeededForInit = if usableInitDecl == nil {
            source.mandatoryVariables
        } else {
            []
        }
    }
}
