//
//  MatiereNameRule.swift
//  demoTableView
//
//  Created by Léo on 08/03/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import Foundation

class MatiereNameRule: Rule {
    
    var detailMessage = String()
    
    var message:String {
        return self.detailMessage
    }
    
    func validate(MatiereName:String) -> Bool {
    
    // Check this when the Rest service will be avalidable
    
        /*for matiere: Matiere in DataNote    //  Vérifie si la matière n'existe pas déjà
        {
            if(matiere.name.lowercaseString == tf_saisieMatiere.text.lowercaseString)
            {
            self.detailMessage = "Cette Matière existe déjà"
                return false
            }
        }*/
    
        return true
    }
    
    func errorMessage() -> String {
        return message
    }
}
