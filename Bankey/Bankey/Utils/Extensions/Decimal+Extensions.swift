//
//  Decimal+Extensions.swift
//  Bankey
//
//  Created by Hussain Mostafa Al Haddad on 10/10/2022.
//

import Foundation

extension Decimal{
    
    var doubleValue: Double{
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
