//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Nada Yehia Dawoud on 5/24/18.
//  Copyright © 2018 Nada Yehia Dawoud. All rights reserved.
//

import Foundation

func square(number: Double) -> Double {
    return pow(number, 2)
}

func cube(number: Double) -> Double {
    return pow(number, 3)
}


struct CalculatorBrain {
    
    private var accumulator: Double?
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation ((Double, Double) -> Double)
        case equals
    }
    
    private let operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "sin": Operation.unaryOperation(sin),
        "cos": Operation.unaryOperation(cos),
        "tan": Operation.unaryOperation(tan),
        "√": Operation.unaryOperation(sqrt),
        "%": Operation.unaryOperation({ $0 / 100 }),
        "+/-": Operation.unaryOperation({ -$0 }),
        "𝒙²": Operation.unaryOperation(square),
        "𝒙³": Operation.unaryOperation(cube),
        "𝒙ʸ": Operation.binaryOperation(pow),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "-": Operation.binaryOperation({ $0 - $1 }),
        "×": Operation.binaryOperation({ $0 * $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "=": Operation.equals,
        ]
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                if accumulator != nil {
                    accumulator = pendingBinaryOperation?.perform(with: accumulator!)
                }
            }
        }
        
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
}
