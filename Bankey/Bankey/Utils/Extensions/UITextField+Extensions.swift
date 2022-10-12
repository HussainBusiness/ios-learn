//
//  UITextField+Extensions.swift
//  Bankey
//
//  Created by Hussain Mostafa Al Haddad on 12/10/2022.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField{
    
    func enablePasswordToggle() {
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: Any){
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
