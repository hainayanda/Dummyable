//
//  ProtocolDeclSyntax+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import SwiftSyntax

extension ProtocolDeclSyntax {
    var isObjectProtocol: Bool {
        inheritanceClause?.inheritedTypes.contains {
            $0.trimmedDescription == "AnyObject"
            || $0.trimmedDescription == "class"
            || $0.trimmedDescription == "NSObject"
        } ?? false
    }
}
