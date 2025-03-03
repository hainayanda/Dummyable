//
//  EnumDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

struct EnumDeclExtraction: TypeDeclExtraction {
    
    private let source: EnumDeclSyntax
    @inlinable var sourceDecl: TypeDeclSyntax { source }
    
    let choosenCase: EnumCaseElementSyntax
    
    @inlinable init(source: EnumDeclSyntax) throws {
        self.source = source
        let choosenCase = source.caseMarkedWithDummyableCaseAttr ?? source.easiestCase
        guard let choosenCase else {
            throw DummyableMacroError.enumCaseNotFound
        }
        self.choosenCase = choosenCase
    }
}

extension DummyEnumFuncDeclFactory {
    @inlinable init(extraction: EnumDeclExtraction) {
        self.init(
            attributes: extraction.usableAttributes,
            modifiers: extraction.modifiers,
            returnType: IdentifierTypeSyntax(name: extraction.declName),
            enumCase: extraction.choosenCase
        )
    }
}
