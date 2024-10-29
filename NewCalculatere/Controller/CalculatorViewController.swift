//
//  CalculatorViewController.swift
//  NewCalculatere
//
//  Created by Анастасия on 29.10.2024.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // модель калькулятора для обработки данныхх
    private let calculatorModel = CalculatorModel()
    
    // представление калькулятора для отображения интерфейса
    
    private let calculatorView = CalculatorView()
    
    
    override func loadView() {
        self.view = calculatorView
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        
        // отображаем Загруженное значение в resultLabel когда запускаем приложение
        calculatorView.resultLabel.text = String(calculatorModel.getCurrentNumber())
    }
    
    
    // настройка кнопок и их добавление
    private func setupButtons() {
        
        // Массив заголовков для каждой кнопки
        let buttonTitles = ["C", "+/-", "%", "/", "7", "8", "9", "X", "4", "5", "6", "-", "1", "2", "3", "+", "RGB", "0", ",", "="]
        
        for row in 0..<5 {
            // массив для хранения кнопок
            var rowButtons: [UIButton] = []
            
            // добавляем 4 кнопки в строку
            for i in 0..<4 {
                let index = row * 4 + i
                guard index < buttonTitles.count else { break }
                
                let isSpecialButton = (i == 3)
                let button = calculatorView.createButton(title: buttonTitles[index], isSpecialButton: isSpecialButton)
                button.addTarget(self, action:
                                    #selector(buttonPressed(_:)), for: .touchUpInside)
                rowButtons.append(button)
            }
            // создание горизонтального стека
            let rowStackView = UIStackView(arrangedSubviews: rowButtons)
            rowStackView.axis = .horizontal
            rowStackView.spacing = 10
            rowStackView.alignment = .fill
            
            calculatorView.mainStackView.addArrangedSubview(rowStackView)
        }
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        
        switch title {
        case "0"..."9":
            if let number = Double(title) {
                calculatorModel.setCurrentNumber(number)
                calculatorView.resultLabel.text = String(calculatorModel.getCurrentNumber())
            }
        case "+", "-", "X", "/":
            calculatorModel.setOperation(title)
        case "=":
            let result = calculatorModel.calculateResult()
            calculatorView.resultLabel.text = String(result)
        case "C":
            calculatorModel.clear()
            calculatorView.resultLabel.text = "0"
        case "+/-":
            calculatorModel.toggleSign()
            calculatorView.resultLabel.text = String(calculatorModel.getCurrentNumber())
        default:
            break
            
            
        }
 
    }
   
}
