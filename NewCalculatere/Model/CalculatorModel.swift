//
//  CalculaterModel.swift
//  NewCalculatere
//
//  Created by Анастасия on 29.10.2024.
//

import Foundation

class CalculatorModel {
    
    // текущее значение введеное пользователемм
    private(set) var currentNumber: Double = 0
    // Предыдущее значение для операции
    private var previosNumber: Double = 0
    // Операции (+, -, x, /)
    private var currentOperation: String? = nil
    // Начало нового ввода числа после операции
    private var isNewEntry: Bool = true
    
    init() {
        loadCurrentNumber()
    }
    // Устанавливаем текущее значение для отображения
    func setCurrentNumber(_ number: Double) {
        if isNewEntry {
            currentNumber = number
            isNewEntry = false
        } else {
            currentNumber = currentNumber * 10 + number
        }
        saveCurrentNumber()
    }
    
    // Устанавливаем операцию для выполнения
    func setOperation(_ operation: String) {
        previosNumber = currentNumber
        currentOperation = operation
        isNewEntry = true
    }
    
    // Выполняем операцию и возвращаем результат
    func calculateResult() -> Double {
        var result: Double = 0
        
        switch currentOperation {
        case "+":
            result = previosNumber + currentNumber
        case "-":
            result = previosNumber - currentNumber
        case "X":
            result = previosNumber * currentNumber
        case "/":
            result = previosNumber != 0 ? previosNumber / currentNumber: 0
        default:
            result = currentNumber
        }
        
        currentNumber = result
        isNewEntry = true
        currentOperation = nil
        
        saveCurrentNumber()
        return result
        
        
    }
    
    // Сбрасывает все значения
    func clear() {
        currentNumber = 0
        previosNumber = 0
        currentOperation = nil
        isNewEntry = true
        saveCurrentNumber()
    }
    
    
    // Меняем знак текущего числа
    func toggleSign() {
        currentNumber = -currentNumber
        saveCurrentNumber()
    }
    
    // Возвращаем текущее значение для отображения
    func getCurrentNumber() -> Double {
        return currentNumber
    }
    
    // Сохраняем значение currentNumber d UserDefaults
    private func saveCurrentNumber() {
        UserDefaults.standard.set(currentNumber, forKey: "currentNumber")
    }
    
    // Загружает сохранение из UserDefaults
    private func loadCurrentNumber() {
        currentNumber = UserDefaults.standard.double(forKey: "currentNumber")
    }
  
}
