//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Ashley Smith on 1/13/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//
import Foundation
import UIKit
struct CalculatorBrain {
    
    var bmi: BMI?
    
    func getBMIValue() -> String {
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiTo1DecimalPlace
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.white
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice."
    }
    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / (height * height)
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more snacks!", color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        } else {
            bmi = BMI(value: bmiValue, advice: "Excerise!", color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        }
       
    }
    
    
}
