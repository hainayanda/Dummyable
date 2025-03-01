//
//  EnumDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct EnumDeclExtraction: TypeDeclExtraction {
    
    let source: EnumDeclSyntax
    var sourceDecl: TypeDeclSyntax { source }
    
    let choosenCase: EnumCaseElementSyntax
    
    init(source: EnumDeclSyntax) throws {
        self.source = source
        let choosenCase = source.caseMarkedWithDummyableCaseAttr ?? source.easiestCase
        guard let choosenCase else {
            throw DummyableMacroError.enumCaseNotFound
        }
        self.choosenCase = choosenCase
    }
}

extension DummiesEnumStaticFuncDeclFactory {
    init(extraction: EnumDeclExtraction) {
        self.init(
            attributes: extraction.usableAttributes,
            modifiers: extraction.modifiers,
            returnType: IdentifierTypeSyntax(name: extraction.declName),
            enumCase: extraction.choosenCase
        )
    }
}
