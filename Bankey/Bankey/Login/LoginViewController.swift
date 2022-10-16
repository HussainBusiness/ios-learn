//
//  ViewController.swift
//  Bankey
//
//  Created by Hussain Mostafa Al Haddad on 06/10/2022.
//

import UIKit

protocol LoginViewControllerDelgate: AnyObject{
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    weak var delegate: LoginViewControllerDelgate?
    
    let headTitle = UILabel()
    let subTitle = UILabel()
    
    var userName: String?{
        return loginView.userNameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    // Animation
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    var titleLeadingAncor: NSLayoutConstraint?
    
    var subTitleLeadingAnchor: NSLayoutConstraint?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       signInButton.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        animate()
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
        headTitle.alpha = 0
        
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
            headTitle.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)])
        
            titleLeadingAncor = headTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
            titleLeadingAncor?.isActive = true
           
            
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subTitle.bottomAnchor, multiplier: 4),
            subTitle.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)])
                                    subTitleLeadingAnchor = subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
                                    subTitleLeadingAnchor?.isActive = true
            
        NSLayoutConstraint.activate([
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
            delegate?.didLogin()
        }else{
            configureView(withMessage: "Incorrect username / password")
        }
        
        
    }
    
    private func configureView(withMessage message: String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton()
    }
    
    private func shakeButton(){
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
    
}

extension LoginViewController{
    
    private func animate(){
        let animator1 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.titleLeadingAncor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        let animator2 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.subTitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        let animator3 = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
            self.headTitle.alpha = 1
            self.view.layoutIfNeeded()
        }
        
        animator1.startAnimation()
        animator2.startAnimation(afterDelay: 1)
        animator3.startAnimation(afterDelay: 0.2)
    }
}
