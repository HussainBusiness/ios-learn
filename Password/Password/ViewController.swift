//
//  ViewController.swift
//  Password
//
//  Created by Hussain Mostafa Al Haddad on 27/10/2022.
//

import UIKit

class ViewController: UIViewController{
    let stackView = UIStackView()
    let passwordTextField = PasswordTextField(placeHolderText: "New Password.")

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController{

    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20

        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    }

    func layout(){

        stackView.addArrangedSubview(passwordTextField)

        view.addSubview(stackView)
        
        // StackView
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
}
