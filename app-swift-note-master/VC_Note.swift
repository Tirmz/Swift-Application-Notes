//
//  VC_Note.swift
//  demoTableView
//
//  Created by userEPSI on 30/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class VC_Note: UIViewController, UIAlertViewDelegate, ValidationDelegate {
    
    var eleve = Eleve()
    var validator = Validator()
    
    var indexOfNote = Int()
    var indexOfMatiere = Int()
    var validationSuccess = false
    var noteWasUpdated = false
    
    var datePicker = UIDatePicker()
    var textField = UITextField()
    
    @IBOutlet weak var l_title: UILabel!

    @IBOutlet weak var l_date: UILabel!
    @IBOutlet weak var l_coef: UILabel!
    @IBOutlet weak var l_verifCoef: UILabel!
    @IBOutlet weak var l_note: UILabel!
    @IBOutlet weak var l_verifNote: UILabel!
    
    @IBOutlet weak var b_date: UIButton!
    @IBOutlet weak var b_coef: UIButton!
    @IBOutlet weak var b_note: UIButton!
    @IBOutlet weak var b_prec: UIButton!
    @IBOutlet weak var b_next: UIButton!
    @IBOutlet weak var b_supp: UIButton!
    
    @IBOutlet weak var tv_desc: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        MesFonctions.convertButton(
            [
                b_date,
                b_coef,
                b_note,
                b_prec,
                b_next,
                b_supp
            ]
        )
        
        self.navigationItem.title = "Notes : \(eleve.matieres[indexOfMatiere].name)"

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if(eleve.matieres[indexOfMatiere].listeNote.count > 0) {
            setDisplay()
        } else {
            navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateNote()
    }
    
    func setDisplay() {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var date = dateFormatter.stringFromDate(
            eleve.matieres[indexOfMatiere].listeNote[indexOfNote].date
        )
        
        l_date.text = date
        l_coef.text = String(
            eleve.matieres[indexOfMatiere].listeNote[indexOfNote].coefficient
        )
        l_note.text = String(
            eleve.matieres[indexOfMatiere].listeNote[indexOfNote].nbPoint
        )
        tv_desc.text = eleve.matieres[indexOfMatiere].listeNote[indexOfNote].description
        l_verifNote.hidden = true
        l_verifCoef.hidden = true
        
        // Display buttons
        if(indexOfNote == 0) {
            b_prec.hidden = true
        } else {
            b_prec.hidden = false
        }
        if(indexOfNote == eleve.matieres[indexOfMatiere].listeNote.count - 1) {
            b_next.hidden = true
        } else {
            b_next.hidden = false
        }
    }
    // MARK: Update function
    
    func updateNote() {
        if(noteWasUpdated == true) {
            let alert = SCLAlertView()
            alert.showWaiting("Chargement", subTitle: "Veuillez patienter pendant le chargement des données")
            eleve.matieres[indexOfMatiere].listeNote[indexOfNote].APIUpdateNote()
            alert.hideView()
            noteWasUpdated = false
        }
    }
    
    func updateDate() {
        let date = datePicker.date
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        l_date.text = dateFormatter.stringFromDate(date)
        eleve.matieres[indexOfMatiere].listeNote[indexOfNote].date = date
    }
    
    @IBAction func modifierDate(sender: AnyObject) {
        
        var datePicker = UIDatePicker(frame: CGRectMake(-8, 180, 300, 300))
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        self.datePicker = datePicker
        
        let alert = SCLAlertView()
        
        alert.kWindowWidth += 50
        alert.kWindowHeight += 200
        
        alert.labelTitle.frame.origin.x += 25
        
        alert.contentView.addSubview(datePicker)
        alert.addButton("Remplacer") {
            self.updateDate()
        }
        
        alert.showEdit("Modifier", subTitle:"Modifier la date d'obtention de la note")
    }
    
    func updateCoef() {
        
        let coef = textField.text
        self.clearErrors(l_verifCoef)
        validator.validateAll(self)
        
        if(validationSuccess == true) {
            eleve.matieres[indexOfMatiere].listeNote[indexOfNote].coefficient = coef.toInt()!
            l_coef.text = coef
            noteWasUpdated = true
            validationSuccess = false
        }
        validator.clearValidation()
        validator.clearErrors()
    }
    
    @IBAction func setCoef(sender: AnyObject) {
        
        let alert = SCLAlertView()
        
        let txt = alert.addTextField(title:"Entrer le coéfficient")
        self.textField = txt
        
        validator.registerField(
            textField: textField,
            errorLabel: l_verifCoef,
            rules: [
                RequiredRule(),
                NoteRule()
            ])
        
        alert.addButton("Remplacer") {
            self.updateCoef()
        }
        alert.showEdit("Modifier", subTitle:"Modifier le coéfficient de la note")
        
    }
    
    func updateNbPoint() {
        let note = textField.text
        self.clearErrors(l_verifCoef)
        validator.validateAll(self)
        
        if(validationSuccess == true) {
            eleve.matieres[indexOfMatiere].listeNote[indexOfNote].nbPoint = note.toInt()!
            l_note.text = note
            noteWasUpdated = true
            validationSuccess = false
        }
        validator.clearValidation()
        validator.clearErrors()
    }
    
    @IBAction func setNote(sender: AnyObject) {
        
        let alert = SCLAlertView()
        
        let txt = alert.addTextField(title:"Entrer la note")
        self.textField = txt
        
        validator.registerField(
            textField: textField,
            errorLabel: l_verifNote,
            rules: [
                RequiredRule(),
                NoteRule()
            ])
        
        alert.addButton("Remplacer") {
            self.updateNbPoint()
        }
        alert.showEdit("Modifier", subTitle:"Modifier la note")
    }
    
    func deleteNote() {
        eleve.matieres[indexOfMatiere].listeNote.removeAtIndex(indexOfNote)
        if (eleve.matieres[indexOfMatiere].listeNote.count == indexOfNote) {
            indexOfNote--
        }
        viewWillAppear(true)
    }
    
    
    @IBAction func backNote(sender: AnyObject) {
        updateNote()
        indexOfNote--
        viewWillAppear(true)
    }
    
    @IBAction func nextNote(sender: AnyObject) {
        updateNote()
        indexOfNote++
        viewWillAppear(true)
    }
    
    @IBAction func DeleteNote(sender: AnyObject) {
        let alert = SCLAlertView()
        
        alert.addButton("Supprimer") {
            self.deleteNote()
        }
        alert.showWarning("Supprimer", subTitle:"Voulez vous supprimer la note ?")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Error Styling
    
    func removeError(#label:UILabel, textField:UITextField) {
        label.hidden = true
        textField.layer.borderWidth = 0.0
    }
    
    func removeAllErrors(label: UILabel, tf: UITextField){
        removeError(
            label: label,
            textField: tf
        )
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationWasSuccessful() {
        validationSuccess = true
    }
    
    func validationFailed(errors:[UITextField:ValidationError]) {
        //  Validation FAILED
        self.setErrors()
    }
    
    private func setErrors(){
        for (field, error) in validator.errors {
            field.layer.borderColor = UIColor.redColor().CGColor
            field.layer.borderWidth = 1.0
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.hidden = false
        }
    }
    
    private func clearErrors(label: UILabel){
        label.text = ""
    }

}
