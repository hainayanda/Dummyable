//
//  AttributeName.swift
//  Injection
//
//  Created by Nayanda Haberty on 22/02/25.
//

import Foundation

@usableFromInline
enum AttributeName {
    case available
    
    @inlinable var applicableAttributes: [String] {
        switch self {
        case .available:
            return ["available"]
        }
    }
}
