//
//  ViewController.swift
//  Calculator
//
//  Created by Nada Yehia Dawoud on 5/24/18.
//  Copyright © 2018 Nada Yehia Dawoud. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var operationDetails: UILabel!
    
    var userIsTyping = false
    
    var calculator = CalculatorBrain()
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(format: "%.10g", newValue)
        }
    }
    
    @IBAction func touchFloatingPoint(_ sender: UIButton) {
        let textInDisplay = display.text!
        if userIsTyping && !textInDisplay.contains(".") {
            display.text = textInDisplay + "."
        }
        if !userIsTyping {
            display.text = "0."
            userIsTyping = true
        }
        
    }
    
    @IBAction func displayInOperationDetails(_ sender: UIButton) {
//      operationDetails.text = operationDetails.text! + " " + sender.currentTitle! + " ..."
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTyping {
            let textInDisplay = display.text!
            display.text = textInDisplay + digit
        }
        else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping {
            calculator.setOperand(displayValue)
            userIsTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            calculator.performOperation(mathematicalSymbol)
        }
        
        if let result = calculator.result {
            displayValue = result
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        display.text = " "
        operationDetails.text = " "
        userIsTyping = false
    }
}

