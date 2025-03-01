//
//  ClassDeclSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

extension ClassDeclSyntax {
    var initDeclMarkedWithDummyableInitAttr: InitializerDeclSyntax? {
        memberBlock.members
            .compactMap {
                $0.decl.as(InitializerDeclSyntax.self)
            }
            .withDummyableInitAttribute()
            .first
    }
}
