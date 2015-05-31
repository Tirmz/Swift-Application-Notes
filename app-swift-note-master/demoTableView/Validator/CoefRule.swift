//
//  CoefRule.swift
//  demoTableView
//
//  Created by Léo on 08/03/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import Foundation

class CoefRule: Rule {
    
    var detailMessage = String()
    
    var message:String {
        return self.detailMessage
    }
    
    func validate(coef:String) -> Bool {
        
        let RegexLettre = "[a-zA-Z]+"
        let RegexFloat = "[,.]+"
        
        if let match = coef.rangeOfString(RegexLettre, options: .RegularExpressionSearch){
            self.detailMessage = "Le coef ne doit pas contenir de lettre"
            return false
        }
        else if let match = coef.rangeOfString(RegexFloat, options: .RegularExpressionSearch)
        {
            self.detailMessage = "Le coef doit être un nombre entier"
            return false
        }
        else if coef.toInt() > 20
        {
            self.detailMessage = "Le coef ne peut pas être supérieur a vinght"
            return false
        }
        else if coef.toInt() < 0
        {
            self.detailMessage = "Le coef doit être supérieur à 0"
            return false
        }
        
        return true
    }
    
    func errorMessage() -> String {
        return message
    }
}
