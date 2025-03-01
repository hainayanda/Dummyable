//
//  ProtocolDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

struct ProtocolDeclExtraction {
    
    typealias DTS = DummyableTokenSyntaxes
    
    let source: ProtocolDeclSyntax
    let attribute: AttributeSyntax
    
    @inlinable
    var generationType: DummyGenerationType {
        get throws {
            let isObjectProtocol = source.isObjectProtocol
            if let fromArguments = try attribute.typeArgumentGenerationType {
                try fromArguments.validate(isObjectProtocol: isObjectProtocol)
                return fromArguments
            } else if isObjectProtocol {
                return .class
            } else {
                throw DummyableMacroError.dummyNeedExplicitType
            }
        }
    }
    
    @inlinable
    var generationName: TokenSyntax {
        source.name.append(DTS.dummyType).trimmed
    }
    
    @inlinable
    var declName: TokenSyntax {
        source.name.trimmed
    }
    
    @inlinable
    var usableAttributes: AttributeListSyntax {
        AttributeListSyntax(
            source.attributes
                .compactMap { $0.as(AttributeSyntax.self) }
                .filter { $0.is(.available) }
                .map { .attribute($0).trimmed }
        )
    }
    
    @inlinable
    var modifiers: DeclModifierListSyntax {
        source.modifiers.trimmed
    }
    
    var variablesNeededForInit: [VariableDeclSyntax] {
        source.memberBlock.members.compactMap {
            $0.decl.as(VariableDeclSyntax.self)?.trimmed
        }
    }
    
    var mandatoryFunctions: [FunctionDeclSyntax] {
        source.memberBlock.members.compactMap {
            $0.decl.as(FunctionDeclSyntax.self)?.trimmed
        }
    }
    
    init(source: ProtocolDeclSyntax, attribute: AttributeSyntax) {
        self.source = source
        self.attribute = attribute
    }
}

extension DummiesStaticFuncDeclFactory {
    init(protocolExtraction: ProtocolDeclExtraction) {
        self.init(
            attributes: protocolExtraction.usableAttributes,
            modifiers: protocolExtraction.modifiers,
            returnType: IdentifierTypeSyntax(name: protocolExtraction.declName),
            initType: DeclReferenceExprSyntax(baseName: protocolExtraction.generationName),
            dummyInitializerParameters: []
        )
    }
}
