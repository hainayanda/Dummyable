//
//  String+Extensions.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import Foundation

extension String {
    static var regexDummyMetaIsGeneric: String = #"(Dummyable\s*\.\s*)?(\s*DummyMetadata\s*)?\.\s*isGeneric\s*\(\s*\[?\s*"#
    + regexSeqOfInt
    + #"\s*\]?\s*\)"#
    
    static var regexDummyMetaConform: String = #"(Dummyable\s*\.\s*)?(\s*DummyMetadata\s*)?\.\s*whereConform\s*\(\s*(\d+)\s*,\s*\[?\s*"#
    + regexSeqOfType
    + #"\s*\]?\s*\)"#
    
    static var regexDummyMetaConformAlt: String = #"(Dummyable\s*\.\s*)?(\s*DummyMetadata\s*)?\.\s*`?where`?\s*\(\s*(\d+)\s*,\s*conform\s*:\s*"#
    + regexSeqOfType
    + #"\s*\)"#
    
    static var regexDummyMetaAvailable: String = #"(Dummyable\s*\.\s*)?(\s*DummyMetadata\s*)?\.\s*available\s*\("#
    + regexDummyMetaAvailableParam
    + #"\)"#
    
    static var regexDummyMetaAvailableParam: String = #"(Dummyable\s*\.\s*)?(\s*DummyMetadata\s*.\s*)?(Platform\s*)?\.\s*\w+\s*\(\d+\.\d+\)?"#
        .regexArrayContent
        .regexCaptured
    
    // Int.self, String.self, Bool.self
    static var regexSeqOfType: String = #"(\(\s*any\s*)?\S+\s*\)?\.self"#
        .regexArrayContent
        .regexCaptured
    
    // 1, 2, 3, 4, 5
    static var regexSeqOfInt: String = regexDecimal.regexArrayContent.regexCaptured
    
    static var regexDecimal: String = "\\d+"
    
    @inlinable var regexAnchored: String { "^\(self)$" }
    
    @inlinable var regexArrayContent: String {
        "\\s*\(self)\\s*(,\\s*\(self)\\s*)*"
    }
    
    @inlinable var regexCaptured: String { "(\(self))" }
    
    
    @inlinable func match(_ regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: .anchorsMatchLines)
            let stringRange = NSRange(location: .zero, length: utf16.count)
            let matches = regex.matches(in: self, range: stringRange)
            return !matches.isEmpty
        } catch {
            return false
        }
    }
    
    @inlinable func matches(_ regex: String) -> [String]? {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: .anchorsMatchLines)
            let stringRange = NSRange(location: .zero, length: utf16.count)
            let matches = regex.matches(in: self, range: stringRange)
            
            return matches.flatMap { match in
                (0 ..< match.numberOfRanges)
                    .map { match.range(at: $0) }
                    .compactMap { Range($0, in: self) }
                    .map { String(self[$0]) }
            }
        } catch {
            return nil
        }
    }
}
