//
//  ExprSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 08/03/25.
//

import SwiftSyntax

extension ExprSyntax {
    func identifierTypeSyntax(metaDatas: [FreestandingMetaData]) -> IdentifierTypeSyntax {
        IdentifierTypeSyntax(
            name: getBaseNameIfHasAny() ?? .identifier(trimmedDescription),
            genericArgumentClause: getGenericArgumentClauseIfHasAny()?
                .replaceWithDefault(
                    at: metaDatas.indexesReplacedWithGenerics
                )
        )
    }
    
    @inlinable func getBaseNameIfHasAny() -> TokenSyntax? {
        if let decl = self.as(DeclReferenceExprSyntax.self) {
            return decl.baseName
        } else if let generic = self.as(GenericSpecializationExprSyntax.self) {
            return generic.expression.getBaseNameIfHasAny()
        } else if let member = self.as(MemberAccessExprSyntax.self) {
            if member.declName.trimmedDescription == "self" {
                return member.base?.getBaseNameIfHasAny()
            } else {
                return member.declName.baseName
            }
        } else {
            return nil
        }
    }
    
    @inlinable func getGenericArgumentClauseIfHasAny() -> GenericArgumentClauseSyntax? {
        if self.as(DeclReferenceExprSyntax.self) != nil {
            return nil
        } else if let generic = self.as(GenericSpecializationExprSyntax.self) {
            return generic.genericArgumentClause
        } else if let member = self.as(MemberAccessExprSyntax.self) {
            if member.declName.trimmedDescription == "self" {
                return member.base?.getGenericArgumentClauseIfHasAny()
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
