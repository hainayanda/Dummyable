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
    static var `private`: DeclModifierSyntax {
        DeclModifierSyntax(name: .keyword(.private))
    }
    
    static var `public`: DeclModifierSyntax {
        DeclModifierSyntax(name: .keyword(.public))
    }
    
    static var `fileprivate`: DeclModifierSyntax {
        DeclModifierSyntax(name: .keyword(.fileprivate))
    }
    
    static var final: DeclModifierSyntax {
        DeclModifierSyntax(name: .keyword(.final))
    }
}
