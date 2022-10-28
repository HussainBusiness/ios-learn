//
//  UITextField+Extensions.swift
//  Password
//
//  Created by Hussain Mostafa Al Haddad on 27/10/2022.
//

import UIKit

let passwordToggleButton = UIButton(type: .custom)
let lockView = UIImageView(image: UIImage(systemName: "lock.fill"))

extension UITextField{
    
    func enablePasswordToggle() {
        passwordToggleButton.setImage(UIImage(systemName: "eye"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordToggleButton
        leftView = lockView
        leftViewMode = .always
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: Any){
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
