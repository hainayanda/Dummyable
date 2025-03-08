//
//  FreestandingDummyMacroTests.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//



#if canImport(DummyableMacro) // macro generation can only be run on macos (on pre-compiling phase)
import XCTest
import SwiftSyntaxMacrosTestSupport
@testable import DummyableMacro

final class FreestandingDummyMacroTests: XCTestCase {
    
    func test_givenBasicDummy_whenExpanded_shouldUseBasicDummyExpansion() {
        assertMacroExpansion(
            basicDummy, expandedSource: basicDummyExpansions,
            macros: ["Dummy": DummyMacro.self]
        )
    }
    
    func test_givenTrailingDummy_whenExpanded_shouldUseTrailingDummyExpansion() {
        assertMacroExpansion(
            trailingDummy, expandedSource: trailingDummyExpansions,
            macros: ["Dummy": DummyMacro.self]
        )
    }
    
    func test_givenPublicDummy_whenExpanded_shouldUsePublicDummyExpansion() {
        assertMacroExpansion(
            publicDummy, expandedSource: publicDummyExpansions,
            macros: ["PublicDummy": DummyMacro.self]
        )
    }
    
    func test_givenPrivateDummy_whenExpanded_shouldUsePrivateDummyExpansion() {
        assertMacroExpansion(
            privateDummy, expandedSource: privateDummyExpansions,
            macros: ["PrivateDummy": DummyMacro.self]
        )
    }
    
    func test_givenGenericDummy_whenExpanded_shouldUseGenericDummyExpansion() {
        assertMacroExpansion(
            genericDummy, expandedSource: genericDummyExpansions,
            macros: ["PrivateDummy": DummyMacro.self]
        )
    }
    
    func test_givenMetaDummy_whenExpanded_shouldUseMetaDummyExpansion() {
        assertMacroExpansion(
            metaAvailabeleConformDummy, expandedSource: metaAvailableConformDummyExpansions,
            macros: ["PrivateDummy": DummyMacro.self]
        )
    }
    
    func test_givenMetaAnyDummy_whenExpanded_shouldUseMetaAnyDummyExpansion() {
        assertMacroExpansion(
            metaAvailabeleConformAnyDummy, expandedSource: metaAvailableConformAnyDummyExpansions,
            macros: ["PrivateDummy": DummyMacro.self]
        )
    }
}

private let basicDummy = #"""
#Dummy(of: Some.self, dummyProvider: {
    Some()
})
"""#

private let basicDummyExpansions = #"""
func dummy(of type: Some.Type) -> Some {
    Some()
}
func dummy(of type: [Some].Type, count: Int) -> [Some] {
    Array(repeat: count) {
        Some()
    }
}
func dummy(of type: Closure<Some>.Type) -> Closure<Some> {
    {
        Some()
    }
}
func dummy<A>(of type: ArgClosure<A, Some>.Type) -> ArgClosure<A, Some> {
    { _ in
        Some()
    }
}
func dummy<A, B>(of type: TwoArgsClosure<A, B, Some>.Type) -> TwoArgsClosure<A, B, Some> {
    { _, _ in
        Some()
    }
}
func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Some>.Type) -> ThreeArgsClosure<A, B, C, Some> {
    { _, _, _ in
        Some()
    }
}
func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Some>.Type) -> FourArgsClosure<A, B, C, D, Some> {
    { _, _, _, _ in
        Some()
    }
}
"""#

private let trailingDummy = #"""
#Dummy(of: Some.self) {
    Some()
}
"""#

private let trailingDummyExpansions = #"""
func dummy(of type: Some.Type) -> Some {
    Some()
}
func dummy(of type: [Some].Type, count: Int) -> [Some] {
    Array(repeat: count) {
        Some()
    }
}
func dummy(of type: Closure<Some>.Type) -> Closure<Some> {
    {
        Some()
    }
}
func dummy<A>(of type: ArgClosure<A, Some>.Type) -> ArgClosure<A, Some> {
    { _ in
        Some()
    }
}
func dummy<A, B>(of type: TwoArgsClosure<A, B, Some>.Type) -> TwoArgsClosure<A, B, Some> {
    { _, _ in
        Some()
    }
}
func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Some>.Type) -> ThreeArgsClosure<A, B, C, Some> {
    { _, _, _ in
        Some()
    }
}
func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Some>.Type) -> FourArgsClosure<A, B, C, D, Some> {
    { _, _, _, _ in
        Some()
    }
}
"""#

private let publicDummy = #"""
#PublicDummy(of: Some.self) {
    Some()
}
"""#

private let publicDummyExpansions = #"""
public func dummy(of type: Some.Type) -> Some {
    Some()
}
public func dummy(of type: [Some].Type, count: Int) -> [Some] {
    Array(repeat: count) {
        Some()
    }
}
public func dummy(of type: Closure<Some>.Type) -> Closure<Some> {
    {
        Some()
    }
}
public func dummy<A>(of type: ArgClosure<A, Some>.Type) -> ArgClosure<A, Some> {
    { _ in
        Some()
    }
}
public func dummy<A, B>(of type: TwoArgsClosure<A, B, Some>.Type) -> TwoArgsClosure<A, B, Some> {
    { _, _ in
        Some()
    }
}
public func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Some>.Type) -> ThreeArgsClosure<A, B, C, Some> {
    { _, _, _ in
        Some()
    }
}
public func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Some>.Type) -> FourArgsClosure<A, B, C, D, Some> {
    { _, _, _, _ in
        Some()
    }
}
"""#

private let privateDummy = #"""
#PrivateDummy(of: Some.self) {
    Some()
}
"""#

private let privateDummyExpansions = #"""
private func dummy(of type: Some.Type) -> Some {
    Some()
}
private func dummy(of type: [Some].Type, count: Int) -> [Some] {
    Array(repeat: count) {
        Some()
    }
}
private func dummy(of type: Closure<Some>.Type) -> Closure<Some> {
    {
        Some()
    }
}
private func dummy<A>(of type: ArgClosure<A, Some>.Type) -> ArgClosure<A, Some> {
    { _ in
        Some()
    }
}
private func dummy<A, B>(of type: TwoArgsClosure<A, B, Some>.Type) -> TwoArgsClosure<A, B, Some> {
    { _, _ in
        Some()
    }
}
private func dummy<A, B, C>(of type: ThreeArgsClosure<A, B, C, Some>.Type) -> ThreeArgsClosure<A, B, C, Some> {
    { _, _, _ in
        Some()
    }
}
private func dummy<A, B, C, D>(of type: FourArgsClosure<A, B, C, D, Some>.Type) -> FourArgsClosure<A, B, C, D, Some> {
    { _, _, _, _ in
        Some()
    }
}
"""#

private let genericDummy = #"""
#PrivateDummy(of: Some<Generic>.self, .isGeneric(0)) {
    Some()
}
"""#

private let genericDummyExpansions = #"""
private func dummy<A>(of type: Some<A>.Type) -> Some<A> {
    Some()
}
private func dummy<A>(of type: [Some<A>].Type, count: Int) -> [Some<A>] {
    Array(repeat: count) {
        Some()
    }
}
private func dummy<A>(of type: Closure<Some<A>>.Type) -> Closure<Some<A>> {
    {
        Some()
    }
}
private func dummy<B, A>(of type: ArgClosure<B, Some<A>>.Type) -> ArgClosure<B, Some<A>> {
    { _ in
        Some()
    }
}
private func dummy<B, C, A>(of type: TwoArgsClosure<B, C, Some<A>>.Type) -> TwoArgsClosure<B, C, Some<A>> {
    { _, _ in
        Some()
    }
}
private func dummy<B, C, D, A>(of type: ThreeArgsClosure<B, C, D, Some<A>>.Type) -> ThreeArgsClosure<B, C, D, Some<A>> {
    { _, _, _ in
        Some()
    }
}
private func dummy<B, C, D, E, A>(of type: FourArgsClosure<B, C, D, E, Some<A>>.Type) -> FourArgsClosure<B, C, D, E, Some<A>> {
    { _, _, _, _ in
        Some()
    }
}
"""#

private let metaAvailabeleConformDummy = #"""
#PrivateDummy(of: Some<Generic>.self, .where(0, conform: EmptyInitializable.self), .available(.iOS(14.0))) {
    Some()
}
"""#

private let metaAvailableConformDummyExpansions = #"""
@available(iOS 14.0, *) private func dummy<A>(of type: Some<A>.Type) -> Some<A> where A: EmptyInitializable {
    Some()
}
@available(iOS 14.0, *) private func dummy<A>(of type: [Some<A>].Type, count: Int) -> [Some<A>] where A: EmptyInitializable {
    Array(repeat: count) {
        Some()
    }
}
@available(iOS 14.0, *) private func dummy<A>(of type: Closure<Some<A>>.Type) -> Closure<Some<A>> where A: EmptyInitializable {
    {
        Some()
    }
}
@available(iOS 14.0, *) private func dummy<B, A>(of type: ArgClosure<B, Some<A>>.Type) -> ArgClosure<B, Some<A>> where A: EmptyInitializable {
    { _ in
        Some()
    }
}
@available(iOS 14.0, *) private func dummy<B, C, A>(of type: TwoArgsClosure<B, C, Some<A>>.Type) -> TwoArgsClosure<B, C, Some<A>> where A: EmptyInitializable {
    { _, _ in
        Some()
    }
}
@available(iOS 14.0, *) private func dummy<B, C, D, A>(of type: ThreeArgsClosure<B, C, D, Some<A>>.Type) -> ThreeArgsClosure<B, C, D, Some<A>> where A: EmptyInitializable {
    { _, _, _ in
        Some()
    }
}
@available(iOS 14.0, *) private func dummy<B, C, D, E, A>(of type: FourArgsClosure<B, C, D, E, Some<A>>.Type) -> FourArgsClosure<B, C, D, E, Some<A>> where A: EmptyInitializable {
    { _, _, _, _ in
        Some()
    }
}
"""#

private let metaAvailabeleConformAnyDummy = #"""
#PrivateDummy(of: Some<Generic>.self, .where(0, conform: (any Equatable).self), .available(.iOS(14.0))) {
    Some()
}
"""#

private let metaAvailableConformAnyDummyExpansions = #"""
@available(iOS 14.0, *) private func dummy<A>(of type: Some<A>.Type) -> Some<A> where A: Equatable {
    Some()
}
@available(iOS 14.0, *) private func dummy<A>(of type: [Some<A>].Type, count: Int) -> [Some<A>] where A: Equatable {
    Array(repeat: count) {
        Some()
    }
}
@available(iOS 14.0, *) private func dummy<A>(of type: Closure<Some<A>>.Type) -> Closure<Some<A>> where A: Equatable {
    {
        Some()
    }
}
@available(iOS 14.0, *) private func dummy<B, A>(of type: ArgClosure<B, Some<A>>.Type) -> ArgClosure<B, Some<A>> where A: Equatable {
    { _ in
        Some()
    }
}
@available(iOS 14.0, *) private func dummy<B, C, A>(of type: TwoArgsClosure<B, C, Some<A>>.Type) -> TwoArgsClosure<B, C, Some<A>> where A: Equatable {
    { _, _ in
        Some()
    }
}
@available(iOS 14.0, *) private func dummy<B, C, D, A>(of type: ThreeArgsClosure<B, C, D, Some<A>>.Type) -> ThreeArgsClosure<B, C, D, Some<A>> where A: Equatable {
    { _, _, _ in
        Some()
    }
}
@available(iOS 14.0, *) private func dummy<B, C, D, E, A>(of type: FourArgsClosure<B, C, D, E, Some<A>>.Type) -> FourArgsClosure<B, C, D, E, Some<A>> where A: Equatable {
    { _, _, _, _ in
        Some()
    }
}
"""#
#endif
