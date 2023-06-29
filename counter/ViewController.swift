//
//  ViewController.swift
//  counter
//
//  Created by Ilya Pogozhev on 30.06.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 3
        return view
    }()
    let counterView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    let buttonPlus: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray3
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.green, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 70)
        button.layer.cornerRadius = 60
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(incrementCounter), for: .touchUpInside)
        return button
    }()
    let buttonMinus: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray3
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.red, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 65)
        button.layer.cornerRadius = 50
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(decrementCounter), for: .touchUpInside)
        return button
    }()
    let counterLabel: UILabel = {
        let label = UILabel()
        label.text = "00000"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 55)
        // - отступ между символами
        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        let letterSpacing: CGFloat = 10
        attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        return label
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cчетчик №1"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.red, for: .highlighted)
        button.addTarget(self, action: #selector(resetCounter), for: .touchUpInside)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3
        return button
    }()
    let changeNameButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil.tip.crop.circle"), for: .normal)
        button.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        return button
    }()
    let infoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Info", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.green, for: .highlighted)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(infoMe), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        setupScene()
        makeConstraints()
        
    }
}
@objc private extension ViewController {
    func setupScene() {
        view.addSubview(mainView)
        mainView.addSubview(counterView)
        view.addSubview(buttonPlus)
        view.addSubview(buttonMinus)
        counterView.addSubview(counterLabel)
        mainView.addSubview(nameLabel)
        view.addSubview(resetButton)
        mainView.addSubview(changeNameButton)
        view.addSubview(infoButton)
    }
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.size.equalTo(400)
            $0.top.equalTo(view)
            $0.left.right.equalTo(view)
        }
        counterView.snp.makeConstraints {
            $0.width.equalTo(250)
            $0.height.equalTo(75)
            $0.centerX.equalTo(mainView)
            $0.centerY.equalTo(mainView).offset(50)
        }
        buttonPlus.snp.makeConstraints {
            $0.size.equalTo(120)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainView.snp.bottom).offset(50)
        }
        buttonMinus.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(buttonPlus.snp.bottom).offset(30)
        }
        counterLabel.snp.makeConstraints {
            $0.top.left.right.bottom.equalTo(counterView)
        }
        nameLabel.snp.makeConstraints {
            $0.centerX.equalTo(mainView)
            $0.centerY.equalTo(mainView).offset(-60)
        }
        resetButton.snp.makeConstraints {
            $0.size.equalTo(60)
            $0.left.equalToSuperview().offset(40)
            $0.bottom.equalToSuperview().offset(-50)
        }
        changeNameButton.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.left.equalTo(nameLabel.snp.right).offset(5)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(56)
        }
        infoButton.snp.makeConstraints {
            $0.size.equalTo(60)
            $0.right.equalToSuperview().offset(-40)
            $0.bottom.equalToSuperview().offset(-50)
            
            
        }
    }
    func incrementCounter() {
        if let counter = Int(counterLabel.text ?? "") {
            let incrementValue = counter + 1
            counterLabel.text = "\(incrementValue)"
        }
    }
    func decrementCounter() {
        if let counter = Int(counterLabel.text ?? "") {
            var decrementValue = counter - 1
            if decrementValue < 0 {
                decrementValue = 0
            }
            counterLabel.text = "\(decrementValue)"
        }
    }
    func resetCounter() {
        counterLabel.text = "0"
    }
    func changeName() {
        let alert = UIAlertController(title: "Счетчик", message: "Введите новое название", preferredStyle: .alert)
           alert.addTextField { (textField) in
               textField.placeholder = "Название"
           }
           
           let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
               if let textField = alert.textFields?.first, let newName = textField.text {
                   self?.nameLabel.text = newName
               }
           }
           alert.addAction(okAction)
           present(alert, animated: true)
    }
    func infoMe() {
        let alertController = UIAlertController(title: "Об авторе", message: "Автор приложения: Погожев Илья", preferredStyle: .alert)
         
         let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         
         alertController.addAction(okAction)
         
         present(alertController, animated: true, completion: nil)
     }
}

