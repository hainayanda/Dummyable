//
//  Dummyable.swift
//  Dummyable
//
//  Created by Nayanda Haberty on 24/02/25.
//

import Foundation
import SwiftUI

public protocol Dummyable {
    static var dummy: Self { get }
}
