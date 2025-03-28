//
//  TypeDeclSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

extension TypeDeclSyntax {
    @inlinable var initDeclMarkedWithDummyableInitAttr: InitializerDeclSyntax? {
        memberBlock.members
            .compactMap {
                $0.decl.as(InitializerDeclSyntax.self)
            }
            .withDummyableInitAttribute()
            .first
    }
    
    @inlinable var initDeclWithMandatoryParameters: InitializerDeclSyntax? {
        let variables = self.mandatoryVariables
        return memberBlock.members
            .compactMap {
                $0.decl.as(InitializerDeclSyntax.self)
            }
            .filter { $0.canBeUsedAsDummyableInit }
            .first { $0.argumentMatched(with: variables) }
    }
    
    @inlinable var mandatoryVariables: [VariableDeclSyntax] {
        memberBlock.members.compactMap {
            $0.decl.as(VariableDeclSyntax.self)
        }
        .filter {
            $0.shouldBeAssignedFromInit
        }
    }
}
