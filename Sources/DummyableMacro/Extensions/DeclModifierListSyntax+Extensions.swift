//
//  DeclModifierListSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 25/02/25.
//

import SwiftSyntax

extension DeclModifierListSyntax {
    
    func noLessThanInternal() -> DeclModifierListSyntax {
        DeclModifierListSyntax {
            self.filter {
                $0.trimmedDescription != "private"
                && $0.trimmedDescription != "fileprivate"
                && $0.trimmedDescription != "internal"
                && $0.trimmedDescription != "final"
            }
        }
    }
    
    func onlyAccessModifier() -> DeclModifierListSyntax {
        DeclModifierListSyntax {
            self.filter {
                $0.trimmedDescription == "private"
                || $0.trimmedDescription == "fileprivate"
                || $0.trimmedDescription == "internal"
                || $0.trimmedDescription == "public"
            }
        }
    }
}

extension DeclModifierSyntax {
    @inlinable static var `public`: DeclModifierSyntax {
        DeclModifierSyntax(name: .keyword(.public))
    }
    
    @inlinable static var `private`: DeclModifierSyntax {
        DeclModifierSyntax(name: .keyword(.private))
    }
    
    @inlinable static var final: DeclModifierSyntax {
        DeclModifierSyntax(name: .keyword(.final))
    }
}
