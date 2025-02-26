//
//  PublisherDummy.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

#if canImport(Combine)
import Combine

extension Future: Dummyable {
    public static var dummy: Future<Output, Failure> {
        Future { _ in }
    }
}

extension Just: Dummyable where Output: Dummyable {
    public static var dummy: Just<Output> {
        Just(Dummies.dummy(of: Output.self))
    }
}

extension AnyPublisher: Dummyable {
    public static var dummy: AnyPublisher<Output, Failure> {
        Empty(completeImmediately: true).eraseToAnyPublisher()
    }
}

extension PassthroughSubject: Dummyable {
    public static var dummy: PassthroughSubject<Output, Failure> {
        PassthroughSubject()
    }
}

extension CurrentValueSubject: Dummyable where Output: Dummyable {
    public static var dummy: CurrentValueSubject<Output, Failure> {
        CurrentValueSubject(Dummies.dummy(of: Output.self))
    }
}

extension AnyCancellable: Dummyable {
    public static var dummy: AnyCancellable {
        AnyCancellable {}
    }
}
#endif
