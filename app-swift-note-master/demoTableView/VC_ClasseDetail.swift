//
//  VC_ClasseDetail.swift
//  demoTableView
//
//  Created by Léo on 25/04/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import UIKit

class VC_ClasseDetail: UIViewController, UITableViewDataSource, UITableViewDelegate, ValidationDelegate {

    var classeListe = Array<Classe>()
    var indexOfClasse = Int()
    var classeUpdated = Bool()
    
    var validator = Validator()
    var activityView = UIActivityIndicatorView()
    
    var textField = UITextField()
    var validationSuccess = Bool()
    
    @IBOutlet weak var l_title: UILabel!
    @IBOutlet weak var l_verifName: UILabel!
    
    @IBOutlet weak var tv_eleve: UITableView!
    
    @IBOutlet weak var b_precedent: UIButton!
    @IBOutlet weak var b_next: UIButton!
    @IBOutlet weak var b_setName: UIButton!
    @IBOutlet weak var b_addClasse: UIButton!
    @IBOutlet weak var b_seeClasse: UIButton!
    @IBOutlet weak var b_delete: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (classeListe.count > 0) {
            MesFonctions.convertButton([
                b_precedent,
                b_next,
                b_setName,
                b_addClasse,
                b_seeClasse,
                b_delete
                ]
            )
            setDisplay()
        } else {
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        classeListe[indexOfClasse].APIgetEleves()
        if (classeListe.count > 0) {
            setDisplay()
            tv_eleve.reloadData()
        } else {
            navigationController?.popViewControllerAnimated(true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDisplay() {
        // Display buttons
        if(indexOfClasse == 0) {
            b_precedent.hidden = true
        } else {
            b_precedent.hidden = false
        }
        if(indexOfClasse == classeListe.count - 1) {
            b_next.hidden = true
        } else {
            b_next.hidden = false
        }
        
        l_title.text = classeListe[indexOfClasse].nom
    }
    
    //MARK: Table view implementation
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classeListe[indexOfClasse].listeEleve.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("eleve") as! UITableViewCell
        
        cell.textLabel?.text = classeListe[indexOfClasse].listeEleve[indexPath.row].nom
        
        return cell
    }
    
    // MARK: - Update functions
    
    func updateClasse() {
        if(classeUpdated == true) {
            classeListe[indexOfClasse].APIUpdate()
            classeUpdated == false
        }
    }
    
    func updateClassName() {
        let newName = textField.text
        self.clearErrors(l_verifName)
        validator.validateAll(self)
        
        if(validationSuccess == true) {
            classeListe[indexOfClasse].nom = newName
            l_title.text = newName
            
            classeUpdated = true
            validationSuccess = false
        }
        validator.clearValidation()
        validator.clearErrors()
    }
    
    func deleteClasse() {
        classeListe[indexOfClasse].APIDelete()
        classeListe.removeAtIndex(indexOfClasse)
        if (classeListe.count == indexOfClasse) {
            indexOfClasse--
        }
        viewWillAppear(true)
    }
    
    @IBAction func UpdateName(sender: AnyObject) {

        let alert = SCLAlertView()
        
        let txt = alert.addTextField(title:"Entrer le nom")
        self.textField = txt
        
        validator.registerField(
            textField: textField,
            errorLabel: l_verifName,
            rules: [
                RequiredRule()
            ]
        )
        
        alert.addButton("Remplacer") {
            self.updateClassName()
        }
        alert.showEdit("Modifier", subTitle:"Modifier le Nom de la Classe")
    }
    
    @IBAction func deleteAction(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.addButton("Supprimer") {
            self.deleteClasse()
        }
        alert.showWarning("Supprimer", subTitle:"Si vous supprimer la classe les élèves seront également supprimé")
    }
    
    // MARK: - Navigation View
    
    @IBAction func backAction(sender: AnyObject) {
        
        updateClasse()
        indexOfClasse--
        self.viewWillAppear(true)
    }
    
    @IBAction func nextAction(sender: AnyObject) {
        activityView.startAnimating()
        updateClasse()
        indexOfClasse++
        self.viewWillAppear(true)
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

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        if let VC = segue!.destinationViewController as? VC_Eleves {
            if let indexPath = tv_eleve.indexPathForSelectedRow() as NSIndexPath? {
                VC.classe = classeListe[indexOfClasse]
                VC.indexOfEleve = indexPath.row
            }
        } else if let VC = segue!.destinationViewController as? VC_AjoutEleve {
                VC.classeListe = classeListe
                VC.indexOfClasse = indexOfClasse
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        updateClasse()
    }
}
