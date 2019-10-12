//
//  List.swift
//  Delta
//
//  Created by Nathan FALLET on 07/10/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import Foundation

struct List: Token {
    
    var values: [Token]
    
    func toString() -> String {
        return "{\(values.map { $0.toString() }.joined(separator: " , "))}"
    }
    
    func compute(with inputs: [String: Token]) -> Token {
        return self
    }
    
    func apply(operation: Operation, right: Token, with inputs: [String: Token]) -> Token {
        return Expression(left: self, right: right, operation: operation)
    }
    
    func needBrackets(for operation: Operation) -> Bool {
        return false
    }
    
    func getMultiplicationPriority() -> Int {
        return 1
    }
    
    func getSign() -> FloatingPointSign {
        return .plus
    }
    
    func changedSign() -> Bool {
        return false
    }
    
}