//
//  Dummies+CoreGraphic.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

#if canImport(CoreGraphics)
import CoreGraphics

// periphery:ignore:parameters type
@inlinable public func dummy(of type: CGSize.Type) -> CGSize { .zero }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: CGPoint.Type) -> CGPoint { .zero }

// periphery:ignore:parameters type
@inlinable public func dummy(of type: CGRect.Type) -> CGRect { .zero }
#endif
