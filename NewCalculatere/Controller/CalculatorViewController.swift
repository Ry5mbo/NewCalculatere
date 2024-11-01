//
//  CalculatorViewController.swift
//  NewCalculatere
//
//  Created by Анастасия on 20.10.2024
//

import UIKit

// Контроллер калькулятора, управляющий логикой и взаимодействием с интерфейсом
class CalculatorViewController: UIViewController {
    
    private let calculatorModel = CalculatorModel()
    private let calculatorView = CalculatorView()
    
    // Заменяет основное view на calculatorView
    override func loadView() {
        self.view = calculatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Устанавливаем кнопки
        setupButtons()
        // Отображаем текущее значение
        calculatorView.resultLabel.text = calculatorModel.getCurrentNumber()
        // Применяем сохранённую тему при запуске
        applyTheme()
    }
    
    // Настройка кнопок и добавление их в интерфейс
    private func setupButtons() {
        let buttonTitles = ["C", "+/-", "%", "/", "7", "8", "9", "X", "4", "5", "6", "-", "1", "2", "3", "+", "RGB", "0", ",", "="]
        
        for row in 0..<5 {
            var rowButtons: [UIButton] = []
            
            for i in 0..<4 {
                let index = row * 4 + i
                guard index < buttonTitles.count else { break }
                
                let isSpecialButton = (i == 3)
                let button = calculatorView.createButton(title: buttonTitles[index], isSpecialButton: isSpecialButton)
                
                // Задаем начальные цвета для каждой кнопки
                if row == 0 && i < 3 {
                    button.backgroundColor = .lightGray
                } else if row >= 1 && row <= 4 && i < 3 {
                    button.backgroundColor = .darkGray
                } else if isSpecialButton {
                    button.backgroundColor = .systemOrange 
                }
                
                // Добавляем действие для нажатия на кнопку
                button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
                rowButtons.append(button)
            }
            
            // Создание горизонтального стека для текущего ряда кнопок
            let rowStackView = UIStackView(arrangedSubviews: rowButtons)
            rowStackView.axis = .horizontal
            rowStackView.spacing = 10
            rowStackView.alignment = .fill
            calculatorView.mainStackView.addArrangedSubview(rowStackView)
        }
    }

    // Метод-обработчик для кнопок калькулятора
    @objc private func buttonPressed(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        
        switch title {
        case "0"..."9":
            if let number = Double(title) {
                calculatorModel.setCurrentNumber(number)
                calculatorView.resultLabel.text = calculatorModel.getCurrentNumber()
            }
        case "+", "-", "X", "/":
            calculatorModel.setOperation(title)
        case "=":
            let result = calculatorModel.calculateResult()
            calculatorView.resultLabel.text = result
        case "C":
            calculatorModel.clear()
            calculatorView.resultLabel.text = "0"
        case "+/-":
            calculatorModel.toggleSign()
            calculatorView.resultLabel.text = calculatorModel.getCurrentNumber()
        case "%":
            calculatorModel.applyPercentage()
            calculatorView.resultLabel.text = calculatorModel.getCurrentNumber()
        case "RGB":
            calculatorModel.switchTheme()
            applyTheme()
        case ",":
            calculatorModel.addDecimal()
        default:
            break
        }
    }
    
    // Применение выбранной темы для всех кнопок
    private func applyTheme() {
        for (rowIndex, stack) in (calculatorView.mainStackView.arrangedSubviews as? [UIStackView] ?? []).enumerated() {
            for (buttonIndex, button) in (stack.arrangedSubviews as? [UIButton] ?? []).enumerated() {
                switch calculatorModel.currentTheme {
                case .light:
                    if buttonIndex == 3 {
                        button.backgroundColor = .systemOrange
                    } else if rowIndex == 0 && buttonIndex < 3 {
                        button.backgroundColor = .lightGray
                    } else {
                        button.backgroundColor = .darkGray
                    }
                case .dark:
                    if buttonIndex == 3 {
                        button.backgroundColor = .systemOrange
                    } else if rowIndex == 0 && buttonIndex < 3 {
                        button.backgroundColor = .systemGray4
                    } else {
                        button.backgroundColor = .systemGray
                    }
                case .colorful:
                    button.backgroundColor = .systemTeal
                }
            }
        }
    }
}
