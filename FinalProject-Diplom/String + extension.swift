//
//  String + extension.swift
//  FinalProject-Diplom
//
//  Created by Ilya on 11.04.2022.
//

import UIKit

extension String {
    
    enum ValidTypes {
        case email
        case password
    }
    
    enum Regex: String {
        case email = "[a-zA-Z0-9._]+@[a-zA-Z]+\\.[a-zA-Z]{2,}"
        case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,24}"
    }
    
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
