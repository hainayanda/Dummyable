//
//  PublisherDummy.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

#if canImport(Combine)
import Combine

#PublicDummy(of: AnyCancellable.self) { AnyCancellable {} }
#endif
