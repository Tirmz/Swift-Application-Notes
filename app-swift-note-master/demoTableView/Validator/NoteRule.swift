//
//  NoteRule.swift
//  demoTableView
//
//  Created by Tristan on 26/03/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import Foundation

class NoteRule: Rule  {
    
    var detailMessage = String()
    
    var message:String {
        return self.detailMessage
    }
    
    func validate(note:String) -> Bool {
        
        let RegexLettre = "[a-zA-Z]+"
        let RegexFloat = "[,.]+"
        
        if let match = note.rangeOfString(RegexLettre, options: .RegularExpressionSearch){
            self.detailMessage = "ERREUR: Lettres détectées"
            return false
        }
        else if note.toInt() > 20
        {
            self.detailMessage = "ERREUR : Note supérieur à 20"
            return false
        }
        else if note.toInt() < 0
        {
            self.detailMessage = "ERREUR : Note négative"
            return false
        }
        
        return true
    }
    
    func errorMessage() -> String {
        return message
    }

   
}
