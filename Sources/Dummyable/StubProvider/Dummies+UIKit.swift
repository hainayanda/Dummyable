//
//  Dummies+UIKit.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

#if canImport(UIKit)
import UIKit

// periphery:ignore:parameters type
@inlinable public func dummy(of type: UIColor.Type) -> UIColor {
    UIColor.clear
}

// periphery:ignore:parameters type
@inlinable public func dummy(of type: UIImage.Type) -> UIImage {
    UIImage()
}

// periphery:ignore:parameters type
@inlinable public func dummy(of type: UIFont.Type) -> UIFont {
    UIFont.systemFont(ofSize: 12)
}

// periphery:ignore:parameters type
@inlinable public func dummy<T: UIView>(of type: T.Type) -> T {
    T()
}

// periphery:ignore:parameters type
@inlinable public func dummy<T: UIViewController>(of type: T.Type) -> T {
    T()
}

// periphery:ignore:parameters type
@inlinable public func dummy<T: UIWindow>(of type: T.Type) -> T {
    T()
}
#endif
