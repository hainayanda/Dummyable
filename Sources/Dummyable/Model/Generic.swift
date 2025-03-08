//
//  Generic.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 04/03/25.
//

// periphery:ignore
public final class Generic {
    @inlinable public init() { }
    @inlinable required public init(from decoder: Decoder) throws { }
    @inlinable required public init?(rawValue: Int) { }
}

extension Generic: Hashable {
    @inlinable public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
}

extension Generic: Equatable {
    @inlinable public static func == (lhs: Generic, rhs: Generic) -> Bool { true }
}

extension Generic: Identifiable { }

extension Generic: Sendable { }

extension Generic: Error { }

extension Generic: Codable {
    @inlinable public func encode(to encoder: Encoder) throws { }
}

extension Generic: CustomStringConvertible {
    @inlinable public var description: String { "Generic" }
}

#PublicDummy(of: Generic.self) { Generic() }
