//
//  StructDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

struct StructDeclExtraction: TypeDeclExtraction {
    
    let source: StructDeclSyntax
    @inlinable var sourceDecl: TypeDeclSyntax { source }
    
    let variablesNeededForInit: [VariableDeclSyntax]
    let usableInitDecl: InitializerDeclSyntax?
    
    @inlinable init(source: StructDeclSyntax) {
        self.source = source
        self.usableInitDecl = source.initDeclMarkedWithDummyableInitAttr ?? source.initDeclWithMandatoryParameters
        self.variablesNeededForInit = if usableInitDecl == nil {
            source.mandatoryVariables
        } else {
            []
        }
    }
}

// MARK: MemberwiseInitDeclFactory + Extensions

extension MemberwiseInitDeclFactory {
    @inlinable init?(extraction: StructDeclExtraction) {
        guard extraction.usableInitDecl == nil else { return nil }
        self.init(
            modifiers: extraction.modifiers.noLessThanInternal(),
            parameters: extraction.variablesNeededForInit.asInitMemberwiseParam()
        )
    }
}
