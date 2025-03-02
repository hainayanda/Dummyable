//
//  DummyableMacroError.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 22/02/25.
//

import Foundation

public enum DummyableMacroError: CustomStringConvertible, Error {
    case needToAttachedToInit
    case attachedToInvalidType(attribute: String, type: String)
    case dummyNeedExplicitType
    case dummyNeedDummyableInit
    case wrongArguments
    case failToGenerateMacro
    case enumCaseNotFound
    
    @inlinable public var description: String {
        switch self {
        case .needToAttachedToInit:
            return "@DummyableInit can only be attached to initializer"
        case .attachedToInvalidType(let attribute, let type):
            return "\(attribute) can only be attached to \(type)"
        case .dummyNeedExplicitType:
            return "Protocol with @Dummyable attribute need explicit Dummyable Type (e.g; @Dummyable(type: .class))"
        case .dummyNeedDummyableInit:
            return "class attached with @Dummyable attribute need init attached with @DummyableInit attribute"
        case .wrongArguments:
            return "Wrong arguments provided"
        case .failToGenerateMacro:
            return "Fail to generate macro"
        case .enumCaseNotFound:
            return "No enumeration case can be found"
        }
    }
}

