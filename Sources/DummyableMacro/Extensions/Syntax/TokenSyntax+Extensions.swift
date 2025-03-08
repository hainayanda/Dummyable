//
//  TokenSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

extension TokenSyntax {
    @inlinable func append(_ token: TokenSyntax) -> TokenSyntax {
        "\(raw: trimmedDescription)\(raw: token.trimmedDescription)"
    }
}
