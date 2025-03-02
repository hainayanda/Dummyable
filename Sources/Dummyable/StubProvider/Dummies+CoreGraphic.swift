//
//  Dummies+CoreGraphic.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 02/03/25.
//

#if canImport(CoreGraphics)
import CoreGraphics

// periphery:ignore
extension Dummies {
    @inlinable public static func dummy(of type: CGSize.Type) -> CGSize { .zero }
    
    @inlinable public static func dummy(of type: CGPoint.Type) -> CGPoint { .zero }
    
    @inlinable public static func dummy(of type: CGRect.Type) -> CGRect { .zero }
}
#endif
