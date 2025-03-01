//
//  EnumDeclSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

import SwiftSyntax

extension EnumDeclSyntax {
    var caseMarkedWithDummyableCaseAttr: EnumCaseElementSyntax? {
        memberBlock.members
            .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
            .filter { $0.hasDummyableCaseAttribute }
            .first?.elements.first
    }
    
    var easiestCase: EnumCaseElementSyntax? {
        memberBlock.members
            .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
            .compactMap { $0.elements.first }
            .enumerated()
            .sorted { first, second in
                guard first.element.parameterCount == second.element.parameterCount else {
                    return first.element.parameterCount < second.element.parameterCount
                }
                return first.offset > second.offset
            }
            .first?.element
    }
}
