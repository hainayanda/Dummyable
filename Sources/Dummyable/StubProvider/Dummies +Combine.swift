//
//  PublisherDummy.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

#if canImport(Combine)
import Combine

// periphery:ignore
extension Dummies {
    public static func dummy<Output, Failure>(of type: Future<Output, Failure>.Type) -> Future<Output, Failure> {
        Future { _ in }
    }
    
    public static func dummy<Output, Failure>(of type: AnyPublisher<Output, Failure>.Type) -> AnyPublisher<Output, Failure> {
        Empty(completeImmediately: true).eraseToAnyPublisher()
    }
    
    public static func dummy<Output, Failure>(of type: PassthroughSubject<Output, Failure>.Type) -> PassthroughSubject<Output, Failure> {
        PassthroughSubject()
    }
    
    public static func dummy(of type: AnyCancellable.Type) -> AnyCancellable {
        AnyCancellable {}
    }
}
#endif
