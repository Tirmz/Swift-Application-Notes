//
//  StringRule.swift
//  demoTableView
//
//  Created by Léo on 08/03/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import UIKit

class StringRule: Rule {
    
    var detailMessage = String()
    
    var message:String {
        return self.detailMessage
    }
    
    func validate(value:String) -> Bool {
   
        let regexChiffre = "[^a-zA-Z]+"
        
        if let match = value.rangeOfString(regexChiffre, options: .RegularExpressionSearch){
            detailMessage = "Seul les lettres sont acceptées"
            return false
        }
        
        return true
    }
    
    func errorMessage() -> String {
        return message
    }
}
