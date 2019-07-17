//
//  Extension.swift
//  First
//
//  Created by User on 6/25/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

public protocol Scopes {}

extension Scopes {
    @inline(__always)func apply(_ block: (Self) -> ()) -> Self {
        block(self)
        return self
    }
    @inline(__always)func run<R>(_ block: (Self) -> R) -> R {
        return block(self)
    }
}

extension Optional: Scopes{}
extension NSObject: Scopes{}
extension String: Scopes{}
extension Array: Scopes{}
extension Int: Scopes{}
extension Double: Scopes{}
extension Dictionary: Scopes{}
extension Float: Scopes{}
extension Bool: Scopes{}
extension Set: Scopes{}
extension URL: Scopes{}
extension URLRequest: Scopes{}
