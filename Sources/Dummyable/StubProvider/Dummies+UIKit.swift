//
//  Dummies+UIKit.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 01/03/25.
//

#if canImport(UIKit)
import UIKit

// periphery:ignore
extension Dummies {
    public static func dummy(of type: UIColor.Type) -> UIColor {
        UIColor.clear
    }
    
    public static func dummy(of type: UIImage.Type) -> UIImage {
        UIImage()
    }
    
    public static func dummy(of type: UIFont.Type) -> UIFont {
        UIFont.systemFont(ofSize: 12)
    }
    
    public static func dummy<T: UIView>(of type: T.Type) -> T {
        T()
    }
    
    public static func dummy<T: UIViewController>(of type: T.Type) -> T {
        T()
    }
    
    public static func dummy<T: UIWindow>(of type: T.Type) -> T {
        T()
    }
}
#endif
