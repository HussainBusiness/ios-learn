//
//  PasswordTextField.swift
//  Password
//
//  Created by Hussain Mostafa Al Haddad on 28/10/2022.
//

import UIKit

class PasswordTextField: UIView {
    
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let textField = UITextField()
    let placeHolderText: String
    let eyebutton = UIButton(type: .custom)
    let divider = UIView()
    let errorMessageLabel = UILabel()
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 60)
    }
}

extension PasswordTextField {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false // true
        textField.placeholder = placeHolderText
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(string:placeHolderText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        
        eyebutton.translatesAutoresizingMaskIntoConstraints = false
        eyebutton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyebutton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyebutton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .separator
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.text = "Your password must meet the requierments below."
        errorMessageLabel.font = .preferredFont(forTextStyle: .footnote)
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.lineBreakMode = .byWordWrapping
        errorMessageLabel.isHidden = false
        
    }
    
    func layout() {
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyebutton)
        addSubview(divider)
        addSubview(errorMessageLabel)
        
        // Lock
        NSLayoutConstraint.activate([
            lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo:leadingAnchor)
        ])
        
        // Text Field
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1),
        ])
        
        // Eye Button
        NSLayoutConstraint.activate([
            eyebutton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor,multiplier: 1),
            eyebutton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyebutton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // Divider
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 4),
            errorMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // CHCR
        lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
        
        
    }
}

// MARK: - Actions

extension PasswordTextField{
    
    @objc func togglePasswordView(_ sender: Any){
        textField.isSecureTextEntry.toggle()
        eyebutton.isSelected.toggle()
    }
}
