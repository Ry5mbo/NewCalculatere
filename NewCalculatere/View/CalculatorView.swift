//
//  CalculatorView.swift
//  NewCalculatere
//
//  Created by Анастасия on 29.10.2024.
//

import UIKit

class CalculatorView: UIView {
    
    // создание Label  
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 56, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Основной вертикальный стек
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) не был реализован")
    }
    
    // Настройка вида элементов интерфейса
    private func setupView() {
        addSubview(resultLabel)
        addSubview(mainStackView)
        
        // Констрейнты в SafeArea
        NSLayoutConstraint.activate([
            //Label
            resultLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            resultLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            resultLabel.heightAnchor.constraint(equalToConstant: 450),
            
            
            
            //Stake
            mainStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 300),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)])
        
        
    }
    
    func createButton(title: String, isSpecialButton: Bool) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        
        
        // Установка размера, округление и цвета текста в кнопке
        
        button.backgroundColor = isSpecialButton ? .systemOrange : .systemGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 40
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return button
        
        
        
    }
}
