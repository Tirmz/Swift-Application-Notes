//
//  MesFonctions.swift
//  demoTableView
//
//  Created by userEPSI on 30/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

struct MesFonctions {
    
    static func parseJSON(inputData: NSData) -> NSDictionary{
        var error: NSError?
        var boardsDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
        
        return boardsDictionary
    }
    
    static func convertButton(buttons: Array<UIButton>){
        for button in buttons {
            button.setImage(button.imageView?.image!.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
            button.imageView?.tintColor = Constants.AppColor
        }
    }
    
    static func randDate() -> NSDate
    {
        let jour = arc4random_uniform(27) + 1
        let mois = arc4random_uniform(11) + 1
        let annee = arc4random_uniform(9) + 2005
        
        var dateString = "\(String(jour))-\(String(mois))-\(String(annee))" // change to your date format
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        var date = dateFormatter.dateFromString(dateString)
                
        return date!
    }
    
    static func RechercheIndexMatiereByName(liste: Array<Matiere>, name: String) -> Int
    {
        var i = 0
        
        for matiere: Matiere in liste
        {
            if(matiere.name == name)
            {
                return i
            }
            i++
        }
        
        return 0
    }
    
    static func RechercheIndexNoteById(liste: Array<Note>, id: Int) -> Int
    {
        var i = 0
        
        for note: Note in liste
        {
            if(note.id == id)
            {
                return i
            }
            i++
        }
        
        return 0
    }
    
    static func MoyenneGenerale(Liste : Array<Matiere>) -> Int
    {
        var sommemoyennematiere = 0
        var sommecoefmatiere = 0
        
        for matiere : Matiere in Liste
        {
            if matiere.listeNote.count > 0
            {
            var sommeCoef = 0
            var sommeNote = 0
            
            for note:Note in matiere.listeNote
            {
                sommeCoef += note.coefficient
                sommeNote += note.nbPoint * note.coefficient
                
            }
            
            sommemoyennematiere += matiere.coefficient * (sommeNote / sommeCoef)
            sommecoefmatiere += matiere.coefficient
        }
            }
        return  18//sommemoyennematiere / sommecoefmatiere
        
    }

   
}
