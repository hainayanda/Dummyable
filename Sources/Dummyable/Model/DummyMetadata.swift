//
//  DummyMetadata.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 05/03/25.
//

import Foundation

public enum DummyMetadata {
    case isGeneric([Int])
    case whereConform(Int, [Any.Type])
    case available([Platform])
    
    @inlinable public static func isGeneric(_ genericAtIndex: Int...) -> DummyMetadata {
        .isGeneric(genericAtIndex)
    }
    
    @inlinable public static func `where`(_ genericAtIndex: Int, conform types: Any.Type...) -> DummyMetadata {
        .whereConform(genericAtIndex, types)
    }
    
    @inlinable public static func available(_ platforms: Platform...) -> DummyMetadata {
        .available(platforms)
    }
        
}

extension DummyMetadata {
    public enum Platform {
        case iOS(Double)
        case iOSApplicationExtension
        case macOS(Double)
        case macOSApplicationExtension
        case macCatalyst
        case macCatalystApplicationExtension
        case watchOS(Double)
        case watchOSApplicationExtension
        case tvOS(Double)
        case tvOSApplicationExtension
        case visionOS(Double)
        case visionOSApplicationExtension
        case swift(Double)
    }
}
