//
//  VC_Matiere.swift
//  demoTableView
//
//  Created by userEPSI on 29/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class VC_Matiere: UIViewController, UITableViewDataSource, UITableViewDelegate, ValidationDelegate {

    var eleve = Eleve()
    var IndexOfmatiere = Int()
    var l_verif = String()
    var matiereWasUpdated = Bool()
    var validationSuccess = Bool()
    
    var validator = Validator()
    var textField = UITextField()
    
    
    @IBOutlet weak var l_title: UILabel!
    @IBOutlet weak var l_verifName: UILabel!
    @IBOutlet weak var l_moyenne: UILabel!
    @IBOutlet weak var l_coef: UILabel!
    @IBOutlet weak var l_verifCoef: UILabel!
    @IBOutlet weak var tv_description: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var b_backButton: UIButton!
    @IBOutlet weak var b_nextButton: UIButton!
    @IBOutlet weak var b_addNote: UIButton!
    @IBOutlet weak var b_setName: UIButton!
    @IBOutlet weak var b_setCoef: UIButton!
    @IBOutlet weak var b_delete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MesFonctions.convertButton([
            b_backButton,
            b_nextButton,
            b_addNote,
            b_setName,
            b_setCoef,
            b_delete
            ]
        )
        
        self.navigationItem.title = "Matière"
        
        if(IndexOfmatiere == 0) {
            b_nextButton.hidden = false
        } else {
            b_backButton.hidden = true
        }
        if(IndexOfmatiere == eleve.matieres.count - 1) {
            b_nextButton.hidden = true
        } else {
            b_backButton.hidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if(eleve.matieres.count > 0) {
            setDisplay()
            tableView.reloadData()
        } else {
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func setDisplay() {
        if(IndexOfmatiere == 0) {
            b_backButton.hidden = true
        } else {
            b_backButton.hidden = false
        }
        
        if(IndexOfmatiere == eleve.matieres.count - 1) {
            b_nextButton.hidden = true
        } else {
            b_nextButton.hidden = false
        }
        
        l_title.text = eleve.matieres[IndexOfmatiere].name
        l_verifName.text = ""
        l_verifCoef.text = ""
        //l_moyenne.text = String(format: "%.2f", moyenne())
        l_coef.text = "\(String(eleve.matieres[IndexOfmatiere].coefficient))"
        tv_description.text = eleve.matieres[IndexOfmatiere].description
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        return eleve.matieres[IndexOfmatiere].listeNote.count
    }
    // MARK: - Update function
    func updateMatiere() {
        if(matiereWasUpdated == true) {
            eleve.matieres[IndexOfmatiere].APIUpdate()
        }
    }
    func setNameMatiere() {
        let name = textField.text
        self.clearErrors(l_verifName)
        validator.validateAll(self)
        
        if(validationSuccess == true) {
            eleve.matieres[IndexOfmatiere].name = name
            l_title.text = name
            matiereWasUpdated = true
            validationSuccess = false
        }
        validator.clearValidation()
        validator.clearErrors()
    }
    
    @IBAction func setNameMatiere(sender: AnyObject) {
        
        let alert = SCLAlertView()
        
        let txt = alert.addTextField(title:"Entrer le nom")
        self.textField = txt
        
        validator.registerField(
            textField: textField,
            errorLabel: l_verifName,
            rules: [
                RequiredRule()
            ])
        
        alert.addButton("Remplacer") {
            self.setNameMatiere()
        }
        alert.showEdit("Modifier", subTitle:"Modifier le nom de la matiere")
    }
    
    func setCoefMatiere() {
        let coef = textField.text
        self.clearErrors(l_verifCoef)
        validator.validateAll(self)

        if(validationSuccess == true) {
            eleve.matieres[IndexOfmatiere].coefficient = coef.toInt()!
            l_coef.text = coef
            matiereWasUpdated = true
            validationSuccess = false
        }
        validator.clearValidation()
        validator.clearErrors()
    }
    
    @IBAction func setCoefMatiere(sender: AnyObject) {

        let alert = SCLAlertView()
        
        let txt = alert.addTextField(title:"Entrer le coéfficient")
        self.textField = txt
        
        validator.registerField(
            textField: textField,
            errorLabel: l_verifCoef,
            rules: [
                RequiredRule()
            ])
        
        alert.addButton("Remplacer") {
            self.setCoefMatiere()
        }
        alert.showEdit("Modifier", subTitle:"Modifier le coéfficient de la matiere")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cellNote") as! UITableViewCell
        
        cell.textLabel!.text = String(
            eleve.matieres[IndexOfmatiere].listeNote[indexPath.row].nbPoint
        )
        cell.detailTextLabel?.text = String(
            eleve.matieres[IndexOfmatiere].listeNote[indexPath.row].coefficient
        )
        
        return cell
    }
    
    func deleteMatiere() {
        eleve.matieres[IndexOfmatiere].APIDelete()
        eleve.matieres.removeAtIndex(IndexOfmatiere)
        if (eleve.matieres.count == IndexOfmatiere) {
            IndexOfmatiere--
        }
        viewWillAppear(true)
    }
    
//    func moyenne() -> Double
//    {
//        var sommeCoef = 0
//        var sommeNote = 0.0
//        
//        for note: Note in DataNote[IndexOfmatiere].listeNote
//        {
//            sommeCoef += note.coefficient
//            sommeNote += note.nbPoint * Double(note.coefficient)
//        }
//        
//        return sommeNote / Double(sommeCoef)
//    }
    

    @IBAction func backMatiere(sender: AnyObject) {
        updateMatiere()
        IndexOfmatiere--
        self.viewWillAppear(true)
    }
    
    @IBAction func nextMatiere(sender: AnyObject) {
        updateMatiere()
        IndexOfmatiere++
        self.viewWillAppear(true)
    }
    @IBAction func DeleteMatiere(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.addButton("Supprimer") {
            self.deleteMatiere()
        }
        alert.showWarning("Supprimer", subTitle:"Souhaitez vous supprimer définitivement la matiere ?")
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
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        if let VC: VC_Note = segue!.destinationViewController as? VC_Note
        {
            VC.eleve = eleve
            
            if let indexPath = tableView.indexPathForSelectedRow() as NSIndexPath?
            {
                VC.indexOfNote = indexPath.row
            }
        }
        
        if let VC: VC_AjoutNote = segue!.destinationViewController as? VC_AjoutNote
        {
            VC.eleve = eleve
            VC.indexOfMatiere = IndexOfmatiere
        }
    }
}
