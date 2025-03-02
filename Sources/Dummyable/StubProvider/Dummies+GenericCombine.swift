//
//  Dummies+GenericCombine.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

#if canImport(Combine)
import Combine

// MARK: Future

// periphery:ignore:parameters type
@inlinable public func dummy<Output, Failure>(of type: Future<Output, Failure>.Type) -> Future<Output, Failure> {
    Future { _ in }
}
// periphery:ignore:parameters type
@inlinable public func dummy<Output, Failure>(of type: Closure<Future<Output, Failure>>.Type) -> Closure<Future<Output, Failure>> {
    {
        dummy(of: Future<Output, Failure>.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, Output, Failure>(of type: ArgClosure<A, Future<Output, Failure>>.Type) -> ArgClosure<A, Future<Output, Failure>> {
    { _ in
        dummy(of: Future<Output, Failure>.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, Output, Failure>(of type: TwoArgsClosure<A, B, Future<Output, Failure>>.Type) -> TwoArgsClosure<A, B, Future<Output, Failure>> {
    { _, _ in
        dummy(of: Future<Output, Failure>.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, Output, Failure>(of type: ThreeArgsClosure<A, B, C, Future<Output, Failure>>.Type) -> ThreeArgsClosure<A, B, C, Future<Output, Failure>> {
    { _, _, _ in
        dummy(of: Future<Output, Failure>.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D, Output, Failure>(of type: FourArgsClosure<A, B, C, D, Future<Output, Failure>>.Type) -> FourArgsClosure<A, B, C, D, Future<Output, Failure>> {
    { _, _, _, _ in
        dummy(of: Future<Output, Failure>.self)
    }
}

// MARK: AnyPublisher

// periphery:ignore:parameters type
@inlinable public func dummy<Output, Failure>(of type: AnyPublisher<Output, Failure>.Type) -> AnyPublisher<Output, Failure> {
    Empty(completeImmediately: true).eraseToAnyPublisher()
}
// periphery:ignore:parameters type
@inlinable public func dummy<Output, Failure>(of type: Closure<AnyPublisher<Output, Failure>>.Type) -> Closure<AnyPublisher<Output, Failure>> {
    {
        dummy(of: AnyPublisher<Output, Failure>.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, Output, Failure>(of type: ArgClosure<A, AnyPublisher<Output, Failure>>.Type) -> ArgClosure<A, AnyPublisher<Output, Failure>> {
    { _ in
        dummy(of: AnyPublisher<Output, Failure>.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, Output, Failure>(of type: TwoArgsClosure<A, B, AnyPublisher<Output, Failure>>.Type) -> TwoArgsClosure<A, B, AnyPublisher<Output, Failure>> {
    { _, _ in
        dummy(of: AnyPublisher<Output, Failure>.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, Output, Failure>(of type: ThreeArgsClosure<A, B, C, AnyPublisher<Output, Failure>>.Type) -> ThreeArgsClosure<A, B, C, AnyPublisher<Output, Failure>> {
    { _, _, _ in
        dummy(of: AnyPublisher<Output, Failure>.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D, Output, Failure>(of type: FourArgsClosure<A, B, C, D, AnyPublisher<Output, Failure>>.Type) -> FourArgsClosure<A, B, C, D, AnyPublisher<Output, Failure>> {
    { _, _, _, _ in
        dummy(of: AnyPublisher<Output, Failure>.self)
    }
}

// MARK: PassthroughSubject

// periphery:ignore:parameters type
@inlinable public func dummy<Output, Failure>(of type: PassthroughSubject<Output, Failure>.Type) -> PassthroughSubject<Output, Failure> {
    PassthroughSubject()
}
// periphery:ignore:parameters type
@inlinable public func dummy<Output, Failure>(of type: Closure<PassthroughSubject<Output, Failure>>.Type) -> Closure<PassthroughSubject<Output, Failure>> {
    {
        dummy(of: PassthroughSubject<Output, Failure>.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, Output, Failure>(of type: ArgClosure<A, PassthroughSubject<Output, Failure>>.Type) -> ArgClosure<A, PassthroughSubject<Output, Failure>> {
    { _ in
        dummy(of: PassthroughSubject<Output, Failure>.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, Output, Failure>(of type: TwoArgsClosure<A, B, PassthroughSubject<Output, Failure>>.Type) -> TwoArgsClosure<A, B, PassthroughSubject<Output, Failure>> {
    { _, _ in
        dummy(of: PassthroughSubject<Output, Failure>.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, Output, Failure>(of type: ThreeArgsClosure<A, B, C, PassthroughSubject<Output, Failure>>.Type) -> ThreeArgsClosure<A, B, C, PassthroughSubject<Output, Failure>> {
    { _, _, _ in
        dummy(of: PassthroughSubject<Output, Failure>.self)
    }
}
// periphery:ignore:parameters type
@inlinable public func dummy<A, B, C, D, Output, Failure>(
    of type: FourArgsClosure<A, B, C, D, PassthroughSubject<Output, Failure>>.Type
) -> FourArgsClosure<A, B, C, D, PassthroughSubject<Output, Failure>> {
    { _, _, _, _ in
        dummy(of: PassthroughSubject<Output, Failure>.self)
    }
}
#endif
