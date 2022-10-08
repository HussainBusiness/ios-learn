//
//  LoginView.swift
//  Bankey
//
//  Created by Hussain Mostafa Al Haddad on 06/10/2022.
//

import Foundation
import UIKit

class LoginView: UIView{
    
    let stackView = UIStackView()
    
    
    let userNameTextField = UITextField()
    let passwordTextField = UITextField()
    
    let divider = UIView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var intrinsicContentSize: CGSize{
//        return CGSize(width: 200, height: 200)
//    }
    
}

extension LoginView{
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 6
        clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        
        
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "User name"
        userNameTextField.text = "hussain"
        userNameTextField.delegate = self
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.text = "password"
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .secondarySystemFill
        
        
        
    }
    
    func layout(){
        
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(divider)
        stackView.addArrangedSubview(passwordTextField)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
        ])
        
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}


extension LoginView: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }
    
}


