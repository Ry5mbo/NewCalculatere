//
//  CalculatorView.swift
//  NewCalculatere
//
//  Created by Анастасия on 20.10.2024
//

import UIKit

// Представление калькулятора, содержащее элементы интерфейса
class CalculatorView: UIView {
    
    // Метка для отображения текущего значения
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 56, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Основной вертикальный стек для размещения строк с кнопками
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Инициализация представления
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupView()
    }
    
    // Требуемый инициализатор при использовании NSCoder
    required init?(coder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    // Метод для размещения элементов интерфейса
    private func setupView() {
        addSubview(resultLabel)
        addSubview(mainStackView)
        
        // Настройка констрейнтов для resultLabel и mainStackView
        NSLayoutConstraint.activate([
            resultLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
                        resultLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
                        resultLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                        resultLabel.heightAnchor.constraint(equalToConstant: 450),
                        
                        
                        
                        //Stake
                        mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
                        mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
                        mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 300),
                        mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // Метод для создания кнопки с заданным заголовком и стилем
    func createButton(title: String, isSpecialButton: Bool) -> UIButton {
        let button = UIButton(type: .system) 
        button.setTitle(title, for: .normal)
        
        // Определяем цвет кнопки в зависимости от ее типа (обычная или специальная)
        button.backgroundColor = isSpecialButton ? .systemOrange : .systemGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 40
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        // Устанавливаем фиксированные размеры для кнопки
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        return button 
    }
}
