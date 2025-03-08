//
//  Platform.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 08/03/25.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

extension FreestandingMetaData {
    public enum Platform: Hashable {
        case iOS(Float)
        case iOSApplicationExtension
        case macOS(Float)
        case macOSApplicationExtension
        case macCatalyst
        case macCatalystApplicationExtension
        case watchOS(Float)
        case watchOSApplicationExtension
        case tvOS(Float)
        case tvOSApplicationExtension
        case visionOS(Float)
        case visionOSApplicationExtension
        case swift(Float)
        case asteriks
        
        @inlinable var expression: ExprSyntax {
            guard let version = version else {
                return ExprSyntax(DeclReferenceExprSyntax(baseName: .identifier(name)))
            }
            return ExprSyntax(
                SequenceExprSyntax {
                    DeclReferenceExprSyntax(baseName: .identifier(name))
                    FloatLiteralExprSyntax(version)
                }
            )
        }
        
        @inlinable var name: String {
            switch self {
            case .iOS: "iOS"
            case .iOSApplicationExtension: "iOSApplicationExtension"
            case .macOS: "macOS"
            case .macOSApplicationExtension: "macOSApplicationExtension"
            case .macCatalyst: "macCatalyst"
            case .macCatalystApplicationExtension: "macCatalystApplicationExtension"
            case .watchOS: "watchOS"
            case .watchOSApplicationExtension: "watchOSApplicationExtension"
            case .tvOS: "tvOS"
            case .tvOSApplicationExtension: "tvOSApplicationExtension"
            case .visionOS: "visionOS"
            case .visionOSApplicationExtension: "visionOSApplicationExtension"
            case .swift: "swift"
            case .asteriks: "*"
            }
        }
        
        @inlinable var version: Float? {
            switch self {
            case .iOS(let version), .macOS(let version),
                    .watchOS(let version), .tvOS(let version),
                    .visionOS(let version), .swift(let version):
                return version
            default: return nil
            }
        }
        
        @inlinable init?(from string: String) {
            let components = string.replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: "(", with: ",")
                .replacingOccurrences(of: ")", with: "")
                .components(separatedBy: ",")
            guard let type = components.first else { return nil }
            
            switch type {
            case ".iOS", "Dummyable.Platform.iOS":
                guard let version = components.last.flatMap(Float.init) else { return nil }
                self = .iOS(version)
            case ".iOSApplicationExtension", "Dummyable.Platform.iOSApplicationExtension":
                self = .iOSApplicationExtension
            case ".macOS", "Dummyable.Platform.macOS":
                guard let version = components.last.flatMap(Float.init) else { return nil }
                self = .macOS(version)
            case ".macOSApplicationExtension", "Dummyable.Platform.macOSApplicationExtension":
                self = .macOSApplicationExtension
            case ".macCatalyst", "Dummyable.Platform.macCatalyst":
                self = .macCatalyst
            case ".macCatalystApplicationExtension", "Dummyable.Platform.macCatalystApplicationExtension":
                self = .macCatalystApplicationExtension
            case ".watchOS", "Dummyable.Platform.watchOS":
                guard let version = components.last.flatMap(Float.init) else { return nil }
                self = .watchOS(version)
            case ".watchOSApplicationExtension", "Dummyable.Platform.watchOSApplicationExtension":
                self = .watchOSApplicationExtension
            case ".tvOS", "Dummyable.Platform.tvOS":
                guard let version = components.last.flatMap(Float.init) else { return nil }
                self = .tvOS(version)
            case ".tvOSApplicationExtension", "Dummyable.Platform.tvOSApplicationExtension":
                self = .tvOSApplicationExtension
            case ".visionOS", "Dummyable.Platform.visionOS":
                guard let version = components.last.flatMap(Float.init) else { return nil }
                self = .visionOS(version)
            case ".visionOSApplicationExtension", "Dummyable.Platform.visionOSApplicationExtension":
                self = .visionOSApplicationExtension
            case ".swift", "Dummyable.Platform.swift":
                guard let version = components.last.flatMap(Float.init) else { return nil }
                self = .swift(version)
            default:
                return nil
            }
        }
    }
}

extension FreestandingMetaData.Platform: Comparable {
    @inlinable public static func < (lhs: FreestandingMetaData.Platform, rhs: FreestandingMetaData.Platform) -> Bool {
        if case .asteriks = lhs { return false }
        else if case .asteriks = rhs { return true }
        guard lhs.name == rhs.name else { return lhs.name < rhs.name }
        let lhsVersion = lhs.version ?? 0
        let rhsVersion = rhs.version ?? 0
        return lhsVersion < rhsVersion
    }
}
