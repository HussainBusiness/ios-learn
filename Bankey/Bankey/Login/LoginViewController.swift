//
//  ViewController.swift
//  Bankey
//
//  Created by Hussain Mostafa Al Haddad on 06/10/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    let headTitle = UILabel()
    let subTitle = UILabel()
    
    var userName: String?{
        return loginView.userNameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
    }


}

extension LoginViewController{
    
    private func style(){
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8 // For indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        
        headTitle.translatesAutoresizingMaskIntoConstraints = false
        headTitle.textAlignment = .center
        headTitle.textColor = .black
        headTitle.numberOfLines = 0
        headTitle.font = headTitle.font.withSize(30)
        headTitle.text = "Bankey"
        
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.textAlignment = .center
        subTitle.textColor = .black
        subTitle.numberOfLines = 2
        subTitle.text = "Your premium source for all things banking!"
    }
    
    private func layout(){
        view.addSubview(headTitle)
        view.addSubview(subTitle)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        NSLayoutConstraint.activate([
            
            subTitle.topAnchor.constraint(equalToSystemSpacingBelow: headTitle.bottomAnchor, multiplier: 4),
            headTitle.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
           
            
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subTitle.bottomAnchor, multiplier: 4),
            subTitle.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 10),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: subTitle.trailingAnchor, multiplier: 10),
            
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2)
        ])
        
    }
}

extension LoginViewController{
    
    @objc func signInButtonTapped(sender: UIButton){
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login(){
        
        guard let userName = userName , let password = password else{
            assertionFailure("Username/Password should never be nil")
            return
        }
        
        if userName.isEmpty || password.isEmpty{
            configureView(withMessage: "Username / password should not be blank")
            return
        }
        
        if userName == "hussain" && password == "password"{
            signInButton.configuration?.showsActivityIndicator = true
        }else{
            configureView(withMessage: "Incorrect username / password")
        }
        
        
    }
    
    private func configureView(withMessage message: String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
}

