//
//  VC_AjoutMatiere.swift
//  demoTableView
//
//  Created by Léo on 25/04/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import UIKit

class VC_AjoutClasse: UIViewController, ValidationDelegate, UITextFieldDelegate  {

    @IBOutlet weak var tf_classeName: UITextField!
    @IBOutlet weak var l_verifName: UILabel!
    @IBOutlet weak var b_addClasse: UIButton!
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MesFonctions.convertButton([b_addClasse])
        
        validator.registerField(
            textField: tf_classeName,
            errorLabel: l_verifName,
            rules: [
                RequiredRule(),
            ]
        )

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addClasse(sender: AnyObject) {
        
        self.clearErrors()
        validator.validateAll(self)
    }
    
    
    // MARK: Error Styling
    
    func removeError(#label:UILabel, textField:UITextField) {
        label.hidden = true
        textField.layer.borderWidth = 0.0
    }
    
    func removeAllErrors(){
        removeError(
            label: l_verifName,
            textField: tf_classeName
        )
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationWasSuccessful() {

        let classe = Classe(Nom: tf_classeName.text)
        classe.APICreate()
        
        SCLAlertView().showSuccess("Ajout Réussi", subTitle: "Votre classe a bien était enregistrer", closeButtonTitle: "Ok", duration: 5.0)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
