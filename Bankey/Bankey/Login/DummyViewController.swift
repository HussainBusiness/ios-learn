//
//  DummyViewController.swift
//  Bankey
//
//  Created by Hussain Mostafa Al Haddad on 08/10/2022.
//

import Foundation
import UIKit

protocol LogoutDelegate: AnyObject{
    func didLogout()
}

class DummyViewController: UIViewController{
    
    let stackView = UIStackView()
    let label = UILabel()
    let logoutButton = UIButton(type: .system)
    weak var logoutDelegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
   
}

extension DummyViewController{
    
    func style(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Log out", for: [])
        logoutButton.configuration = .filled()
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout(){
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
       
    }
}

// MARK: - Actions

extension DummyViewController{
    
    @objc func logoutButtonTapped(sender: UIButton){
        logoutDelegate?.didLogout()
    }
}

