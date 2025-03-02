//
//  InitializerParameter.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

import SwiftSyntax

@usableFromInline
struct InitializerParameter {
    let name: TokenSyntax?
    let type: TypeSyntax
}
