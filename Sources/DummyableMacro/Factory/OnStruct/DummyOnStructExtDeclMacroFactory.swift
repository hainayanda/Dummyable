//
//  DummyOnStructExtDeclMacroFactory.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

struct DummyOnStructExtDeclMacroFactory: ExtDeclSyntaxExpander, DummyConcreteInitCodeBuilder {
    
    typealias DTS = DummyableTokenSyntaxes
    
    let extraction: StructDeclExtraction
    var typeDeclExtraction: TypeDeclExtracting { extraction }
    var staticDummyType: TokenSyntax { typeDeclExtraction.declName }
    var dummyInitializerParameters: [ParameterDeclExtraction] {
        guard let usableInitDecl = typeDeclExtraction.usableInitDecl else { return [] }
        return usableInitDecl.signature.parameterClause.parameters
            .filter { $0.defaultValue == nil }
            .compactMap {
                ParameterDeclExtraction(
                    name: $0.firstName,
                    type: $0.type
                )
            }
    }
    var shouldGenerateInit: Bool { typeDeclExtraction.usableInitDecl == nil }
    
    init(extraction: StructDeclExtraction) {
        self.extraction = extraction
    }
    
    func expandExtensionCodeGeneration() throws -> ExtensionDeclSyntax {
        try ExtensionDeclSyntax(
            extendedType: IdentifierTypeSyntax(name: typeDeclExtraction.declName),
            inheritanceClause: buildInherintanceClause()) {
                try buildDummyStaticVariableDecl()
                if shouldGenerateInit {
                    try buildInitDecl()
                }
        }
    }
    
    private func buildInherintanceClause() -> InheritanceClauseSyntax {
        InheritanceClauseSyntax(
            inheritedTypes: InheritedTypeListSyntax {
                InheritedTypeSyntax(
                    type: IdentifierTypeSyntax(name: DTS.dummyableType)
                )
            }
        )
    }
}
