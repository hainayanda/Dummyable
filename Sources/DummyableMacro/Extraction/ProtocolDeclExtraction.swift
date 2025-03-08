//
//  ProtocolDeclExtraction.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

struct ProtocolDeclExtraction: TypeDeclExtraction {
    
    typealias DTS = DummyableTokenSyntaxes
    
    private let source: ProtocolDeclSyntax
    @inlinable var sourceDecl: TypeDeclSyntax { source }
    
    let attribute: AttributeSyntax
    
    @inlinable var generationType: DummyGenerationType {
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
    
    @inlinable var generationName: TokenSyntax {
        source.name.append(DTS.dummyType).trimmed
    }
    
    let variablesNeededForInit: [VariableDeclSyntax]
    
    @inlinable var mandatoryFunctions: [FunctionDeclSyntax] {
        source.memberBlock.members.compactMap {
            $0.decl.as(FunctionDeclSyntax.self)?.trimmed
        }
    }
    
    @inlinable var mandatoryInits: [InitializerDeclSyntax] {
        let fromProtocol = source.memberBlock.members.compactMap {
            $0.decl.as(InitializerDeclSyntax.self)?.trimmed
        }
        .filter {
            $0.isSimilar(with: .baseVoidInit) == false
        }
        return [.baseVoidInit] + fromProtocol
    }
    
    var usableInitDecl: InitializerDeclSyntax?
    
    @inlinable init(source: ProtocolDeclSyntax, attribute: AttributeSyntax) {
        self.source = source
        self.attribute = attribute
        self.variablesNeededForInit = source.memberBlock.members.compactMap {
            $0.decl.as(VariableDeclSyntax.self)?.trimmed
        }
    }
}

// MARK: DummyInitFuncDeclFactory + Extensions

extension DummyInitFuncDeclFactory {
    @inlinable init(protocolExtraction: ProtocolDeclExtraction) {
        self.init(
            attributes: protocolExtraction.usableAttributes,
            modifiers: protocolExtraction.modifiers,
            returnType: IdentifierTypeSyntax(name: protocolExtraction.declName),
            initType: DeclReferenceExprSyntax(baseName: protocolExtraction.generationName),
            dummyInitializerParameters: []
        )
    }
}

// MARK: DummyClosureFuncDeclFactory + Extensions

extension DummyClosuresFuncDeclFactory {
    @inlinable init(protocolDecl: ProtocolDeclSyntax, node: AttributeSyntax) {
        let extraction = ProtocolDeclExtraction(source: protocolDecl, attribute: node)
        self.init(
            typeExtraction: extraction,
            creationType: .emptyInitCall(extraction.generationName)
        )
    }
}
