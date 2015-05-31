//
//  VC_AjoutMatiere.swift
//  demoTableView
//
//  Created by userEPSI on 30/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class VC_AjoutMatiere: UIViewController, ValidationDelegate, UITextFieldDelegate {
    
    var DataNote = Array<Matiere>()
    var matiere = String()
    
    @IBOutlet weak var tf_saisieMatiere: UITextField!
    @IBOutlet weak var tf_coefMatiere: UITextField!
    @IBOutlet weak var tv_desc: UITextView!
    @IBOutlet weak var l_verifNom: UILabel!
    @IBOutlet weak var l_verifCoef: UILabel!

    @IBOutlet weak var b_add: UIButton!
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MesFonctions.convertButton([b_add])
        
        self.navigationItem.title = "Ajout Matiere"

        // Do any additional setup after loading the view.
        
        validator.registerField(
            textField: tf_saisieMatiere,
            errorLabel: l_verifNom,
            rules: [
                RequiredRule(),
                StringRule(),
                MatiereNameRule()
            ]
        )
        
        validator.registerField(
            textField: tf_coefMatiere,
            errorLabel: l_verifCoef,
            rules: [
                RequiredRule(),
                CoefRule()
            ]
        )
  
    }
    
    @IBAction func AjouterMatiere(sender: AnyObject) {
        // Validating...
        self.clearErrors()
        validator.validateAll(self)
    }
    
   override func viewWillDisappear(animated: Bool) {
    
   }
    
    // MARK: Error Styling
    
    func removeError(#label:UILabel, textField:UITextField) {
        label.hidden = true
        textField.layer.borderWidth = 0.0
    }
    
    func removeAllErrors(){
        removeError(
            label:l_verifNom,
            textField: tf_saisieMatiere
        )
        removeError(
            label: l_verifCoef,
            textField: tf_coefMatiere
        )
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationWasSuccessful() {
        
        let matiere = Matiere(Name: tf_saisieMatiere.text, Coefficient: tf_coefMatiere.text.toInt()!, Description: tv_desc.text)
        
        matiere.APICreateMatiere()
        
        SCLAlertView().showSuccess("Ajout Réussi", subTitle: "Votre matière a bien était enregistrer", closeButtonTitle: "Ok", duration: 5.0)
        
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
    
    private func clearErrors(){
        for (field, error) in validator.errors {
            field.layer.borderWidth = 0.0
            error.errorLabel?.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if let VC: ViewController = segue.destinationViewController as? ViewController
        {
            VC.eleve.matieres = DataNote
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
