//
//  ViewController.swift
//  Password
//
//  Created by Hussain Mostafa Al Haddad on 27/10/2022.
//

import UIKit

class ViewController: UIViewController{
    let stackView = UIStackView()
    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password.")
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new Password.")
    let resetButton = UIButton(type: .custom)
    
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

        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 5
        statusView.clipsToBounds = true
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
     //   resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)

    }

    func layout(){

        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
        view.addSubview(stackView)
        
        // StackView
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
}
