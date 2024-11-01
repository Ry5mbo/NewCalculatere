//
//  CalculaterModel.swift
//  NewCalculatere
//
//  Created by Анастасия on 20.10.2024
//

import UIKit

// Модель калькулятора, выполняющая операции и сохраняющая состояние
class CalculatorModel {
    
    // Текущее значение, введенное пользователем
    private(set) var currentNumber: Double = 0
    // Предыдущее значение для выполнения операций
    private var previousNumber: Double = 0
    // Операция, выбранная пользователем (+, -, *, /)
    private var currentOperation: String? = nil
    // начало нового ввода числа после операции
    private var isNewEntry: Bool = true
    // для отслеживания, была ли введена десятичная точка
    private var isDecimal: Bool = false
    // Множитель для добавления десятичных чисел
    private var decimalFactor: Double = 0.1
    // Текущая тема калькулятора
    private(set) var currentTheme: Theme = .light
    
    // Перечисление для доступных цветовых тем
    enum Theme: Int {
        case light = 0
        case dark
        case colorful
    }
    
    // Инициализатор, загружающий текущий номер и тему при запуске
    init() {
        loadCurrentNumber()
        loadCurrentTheme()
    }
    
    // Метод для установки текущего числа. Если число новое, оно устанавливается как новое или продолжение изначального числа
    func setCurrentNumber(_ number: Double) {
        if isNewEntry {
            currentNumber = number
            isNewEntry = false
        } else if isDecimal {
            currentNumber += number * decimalFactor
            decimalFactor *= 0.1
        } else {
            currentNumber = currentNumber * 10 + number
        }
        saveCurrentNumber()
    }
    
    // Метод для добавления десятичных чисел
    func addDecimal() {
        if !isDecimal {
            isDecimal = true
            decimalFactor = 0.1
        }
    }
    
    // Метод для установки операции, сохраняет текущее число и операцию, затем ожидает новый ввод
    func setOperation(_ operation: String) {
        previousNumber = currentNumber
        currentOperation = operation
        isNewEntry = true
        isDecimal = false
    }
    
    // Метод для выполнения выбранной операции и возвращения результата как отформатированной строки
    func calculateResult() -> String {
        var result: Double = 0
        switch currentOperation {
        case "+":
            result = previousNumber + currentNumber
        case "-":
            result = previousNumber - currentNumber
        case "X":
            result = previousNumber * currentNumber
        case "/":
            result = currentNumber != 0 ? previousNumber / currentNumber : 0
        default:
            result = currentNumber
        }
        
        currentNumber = result
        isNewEntry = true
        isDecimal = false
        currentOperation = nil
        saveCurrentNumber()
        return formatNumber(result)
    }
    
    // Метод для преобразования текущего числа в процентное значение
    func applyPercentage() {
        currentNumber /= 100
        saveCurrentNumber()
    }
    
    // Метод для очистки всех значений и сброса флагов
    func clear() {
        currentNumber = 0
        previousNumber = 0
        currentOperation = nil
        isNewEntry = true
        isDecimal = false
        saveCurrentNumber()
    }
    
    // Метод для смены знака текущего числа
    func toggleSign() {
        currentNumber = -currentNumber
        saveCurrentNumber()
    }
    
    // Возвращает текущее число в виде отформатированной строки
    func getCurrentNumber() -> String {
        return formatNumber(currentNumber)
    }
    
    // Переключает тему калькулятора и сохраняет текущую тему
    func switchTheme() {
        currentTheme = Theme(rawValue: (currentTheme.rawValue + 1) % 3) ?? .light
        saveCurrentTheme()
    }
    
    // Приватный метод для форматирования числа с разделением тысячных и без 
    private func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 8
        formatter.groupingSeparator = " "
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    // Сохраняет значение currentNumber в UserDefaults
    private func saveCurrentNumber() {
        UserDefaults.standard.set(currentNumber, forKey: "currentNumber")
    }
    
    // Загружает сохраненное значение из UserDefaults
    private func loadCurrentNumber() {
        currentNumber = UserDefaults.standard.double(forKey: "currentNumber")
    }
    
    // Сохраняет текущую тему в UserDefaults
    private func saveCurrentTheme() {
        UserDefaults.standard.set(currentTheme.rawValue, forKey: "currentTheme")
    }
    
    // Загружает сохранённую тему из UserDefaults
    private func loadCurrentTheme() {
        if let savedTheme = Theme(rawValue: UserDefaults.standard.integer(forKey: "currentTheme")) {
            currentTheme = savedTheme
        }
    }
}
