//
//  FreestandingMetaData.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 06/03/25.
//

import Foundation
import SwiftSyntax

public enum FreestandingMetaData {
    case isGeneric([Int])
    case whereConform(Int, [TokenSyntax])
    case available([Platform])
    
    var asGenericRequirement: [GenericRequirementSyntax] {
        switch self {
        case .whereConform(let index, let tokens):
            tokens.map { token in
                GenericRequirementSyntax(
                    requirement: .conformanceRequirement(
                        ConformanceRequirementSyntax(
                            leftType: IdentifierTypeSyntax(name: DummyableTokenSyntaxes.genericTypes[index]),
                            rightType: IdentifierTypeSyntax(name: token)
                        )
                    )
                )
            }
        default: []
        }
    }
    
    init?(from labeled: LabeledExprSyntax) {
        
        let expression = labeled.expression.trimmedDescription
        if let indexes = expression.dummyMetaDataIsGenericIndexes() {
            self = .isGeneric(indexes)
        } else if let indexWhereConformType = expression.dummyMetaDataWhereConformType() {
            self = .whereConform(indexWhereConformType.0, indexWhereConformType.1)
        } else if let platforms = expression.dummyMetaDataAvailablePlatforms() {
            self = .available(platforms + [.asteriks])
        } else {
            return nil
        }
    }
}

// MARK: Sequence of FreestandingMetaData

extension Sequence where Element == FreestandingMetaData {
    
    typealias DTS = DummyableTokenSyntaxes
    
    @inlinable var indexesReplacedWithGenerics: [Int] {
        reduce(into: Set<Int>()) { partialResult, element in
            switch element {
            case .isGeneric(let indexes):
                partialResult.formUnion(indexes)
            case .whereConform(let index, _):
                partialResult.insert(index)
            default: break
            }
        }
        .map { $0 }
        .sorted(by: <)
    }
    
    var genericParameters: GenericParameterListSyntax? {
        let indexes = indexesReplacedWithGenerics
        guard !indexes.isEmpty else { return nil }
        return GenericParameterListSyntax {
            for index in indexes {
                GenericParameterSyntax(
                    name: DTS.genericTypes[index]
                )
            }
        }
    }
    
    var genericParametersClause: GenericParameterClauseSyntax? {
        guard let genericParameters else { return nil }
        return GenericParameterClauseSyntax(parameters: genericParameters)
    }
    
    var attributes: AttributeListSyntax? {
        guard let availableAttributes = availableAttributes else {
            return nil
        }
        return AttributeListSyntax { availableAttributes }
    }
    
    var availableAttributes: AttributeSyntax? {
        let platforms = compactMap { element -> [FreestandingMetaData.Platform]? in
            guard case .available(let platforms) = element else { return nil }
            return platforms
        }
            .flatMap { $0 }
            .sorted(by: <)
        
        guard !platforms.isEmpty else { return nil }
        
        return AttributeSyntax(
            attributeName: IdentifierTypeSyntax(name: DTS.available),
            leftParen: .leftParenToken(),
            arguments: .argumentList(LabeledExprListSyntax {
                for platform in platforms {
                    LabeledExprSyntax(
                        expression: platform.expression
                    )
                }
            }),
            rightParen: .rightParenToken()
        )
    }
    
    var genericWhereClauses: GenericWhereClauseSyntax? {
        let genericList = GenericRequirementListSyntax {
            for element in self {
                for requirement in element.asGenericRequirement {
                    requirement
                }
            }
        }
        guard !genericList.isEmpty else {
            return nil
        }
        return GenericWhereClauseSyntax(requirements: genericList)
    }
    
    @inlinable func compacted() -> [FreestandingMetaData] {
        var isGenerics: Set<Int> = []
        var whereConform: [Int: [TokenSyntax]] = [:]
        var availables: Set<FreestandingMetaData.Platform> = []
        for element in self {
            switch element {
            case .isGeneric(let indexes):
                isGenerics.formUnion(indexes)
            case .whereConform(let index, let tokens):
                whereConform[index, default: []].append(contentsOf: tokens)
            case .available(let platforms):
                availables.formUnion(platforms)
            }
        }
        var results: [FreestandingMetaData] = []
        if !isGenerics.isEmpty {
            results.append(.isGeneric(Array(isGenerics)))
        }
        if !whereConform.isEmpty {
            for (index, tokens) in whereConform {
                results.append(.whereConform(index, tokens))
            }
        }
        if !availables.isEmpty {
            results.append(.available(Array(availables)))
        }
        return results
    }
}

// MARK: Private Extensions

private extension String {
    func dummyMetaDataIsGenericIndexes() -> [Int]? {
        guard let matches = matches(.regexDummyMetaIsGeneric.regexAnchored) else {
            return nil
        }
        
        let indexes = matches.first { $0.match(.regexSeqOfInt.regexAnchored) }?
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .compactMap { Int($0) }
        
        guard let indexes, !indexes.isEmpty else {
            return nil
        }
        return indexes
    }
    
    
    func dummyMetaDataWhereConformType() -> (Int, [TokenSyntax])? {
        dummyMetaDataWhereExtraction(.regexDummyMetaConform)
        ?? dummyMetaDataWhereExtraction(.regexDummyMetaConformAlt)
    }
    
    func dummyMetaDataAvailablePlatforms() -> [FreestandingMetaData.Platform]? {
        guard let matches = matches(.regexDummyMetaAvailable.regexAnchored) else {
            return nil
        }
        let platforms = matches.first { $0.match(.regexDummyMetaAvailableParam.regexAnchored) }?
            .components(separatedBy: ",")
            .compactMap { FreestandingMetaData.Platform(from: $0) }
        guard let platforms, !platforms.isEmpty else {
            return nil
        }
        return platforms
    }
    
    
    func dummyMetaDataWhereExtraction(_ regex: String) -> (Int, [TokenSyntax])? {
        guard let matches = matches(regex.regexAnchored),
              let indexString = matches.first(where: { $0.match(.regexDecimal.regexAnchored) }),
              let index = Int(indexString) else {
            return nil
        }
        
        let tokens = matches.first { $0.match(.regexSeqOfType.regexAnchored) }?
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map {
                $0.replacingOccurrences(of: #"^\(\s*any\s*"#, with: "", options: .regularExpression)
            }
            .map {
                $0.replacingOccurrences(of: #"(\s*\))?\.self$"#, with: "", options: .regularExpression)
            }
            .compactMap { TokenSyntax(stringLiteral: $0) }
        
        guard let tokens, !tokens.isEmpty else {
            return nil
        }
        return (index, tokens)
    }
}
