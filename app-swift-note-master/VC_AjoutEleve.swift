import UIKit

class VC_AjoutEleve: UIViewController, ValidationDelegate, UITextFieldDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var lb_verifFirstName: UILabel!
    @IBOutlet weak var lb_verifName: UILabel!
    @IBOutlet weak var txt_nameEleve: UITextField!
    @IBOutlet weak var txt_firstnameEleve: UITextField!
    @IBOutlet weak var tf_email: UITextField!
    @IBOutlet weak var l_verifEmail: UILabel!
    @IBOutlet weak var l_dateOfBirth: UILabel!
    @IBOutlet weak var l_classe: UILabel!
    
    @IBOutlet weak var b_dateOfBirth: UIButton!
    @IBOutlet weak var b_classe: UIButton!
    @IBOutlet weak var b_add: UIButton!
    
    var classeListe = Array<Classe>()
    var indexOfClasse = 0
    
    let validator = Validator()
    var datePicker = UIDatePicker()
    var classePicker = ClassePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MesFonctions.convertButton([b_dateOfBirth, b_classe, b_add])
        
        validator.registerField(
            textField: txt_nameEleve,
            errorLabel: lb_verifName,
            rules: [
                RequiredRule(),
                StringRule(),
            ]
        )
        
        validator.registerField(
            textField: txt_firstnameEleve,
            errorLabel: lb_verifFirstName,
            rules: [
                RequiredRule(),
                StringRule(),
            ]
        )
        
        validator.registerField(
            textField: tf_email,
            errorLabel: l_verifEmail,
            rules: [
                RequiredRule(),
            ]
        )
        
        setDisplayAjoutEleve()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDisplayAjoutEleve()
    {
        txt_firstnameEleve.layer.borderColor = Constants.AppColor.CGColor
        txt_firstnameEleve.layer.borderWidth = 1
        txt_firstnameEleve.layer.cornerRadius = 5
        
        txt_nameEleve.layer.borderColor = Constants.AppColor.CGColor
        txt_nameEleve.layer.borderWidth = 1
        txt_nameEleve.layer.cornerRadius = 5
        
        tf_email.layer.borderColor = Constants.AppColor.CGColor
        tf_email.layer.borderWidth = 1
        tf_email.layer.cornerRadius = 5
        
        lb_verifFirstName.hidden = true
        lb_verifName.hidden = true
        l_verifEmail.hidden = true
        
        let date = datePicker.date
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        l_dateOfBirth.text = dateFormatter.stringFromDate(date)
        
        l_classe.text = classeListe[indexOfClasse].nom
    }
    
    
    @IBAction func addEleve(sender: AnyObject) {
        // Validating ...
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
            label: lb_verifName,
            textField: txt_nameEleve
        )
        removeError(
            label: lb_verifFirstName,
            textField: txt_firstnameEleve
        )
        removeError(
            label: l_verifEmail,
            textField: tf_email
        )
    }
    
    func setDate() {
        let date = datePicker.date
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        l_dateOfBirth.text = dateFormatter.stringFromDate(date)
    }
    
    @IBAction func setDateOfBirth(sender: AnyObject) {
        
        let PickerDate = UIDatePicker()
        PickerDate.datePickerMode = UIDatePickerMode.Date
        
        datePicker = PickerDate
        
        var datePickerOfbirth = UIDatePicker(frame: CGRectMake(-8, 180, 300, 300))
        datePickerOfbirth.datePickerMode = UIDatePickerMode.Date
        
        datePicker = datePickerOfbirth
        
        let alert = SCLAlertView()
        
        alert.kWindowWidth += 50
        alert.kWindowHeight += 200
        
        alert.labelTitle.frame.origin.x += 25
        
        alert.contentView.addSubview(datePickerOfbirth)
        alert.addButton("Ok") {
            self.setDate()
        }
        
        alert.showEdit("Modifier", subTitle:"Modifier la date de naissance de l'élève")
    }
    
    func setClasse() {
        indexOfClasse = classePicker.selectedRowInComponent(0)
        l_classe.text = classeListe[indexOfClasse].nom
    }
    
    @IBAction func setClasse(sender: AnyObject) {
        var picker = ClassePicker(frame: CGRectMake(-8, 180, 300, 300))
        
        picker.classeListe = classeListe
        picker.delegate = picker
        picker.dataSource = picker
        
        classePicker = picker
        picker.selectRow(indexOfClasse, inComponent: 0, animated: false)
        
        let alert = SCLAlertView()
        
        alert.kWindowWidth += 50
        alert.kWindowHeight += 200
        
        alert.labelTitle.frame.origin.x += 25
        
        alert.contentView.addSubview(picker)
        alert.addButton("Ok") {
            self.setClasse()
        }
        
        alert.showEdit("Modifier", subTitle:"Modifier la classe de l'élève")
    }
        
    // MARK: ValidationDelegate Methods
    
    func validationWasSuccessful() {
        
        //  Validation SUCCESS
        
        var eleve = Eleve(lastName: txt_nameEleve.text, firstName: txt_firstnameEleve.text, email: tf_email.text, dateOfBirth: l_dateOfBirth.text!, classe: classeListe[indexOfClasse])
        
        eleve.APIAdd()
    
        SCLAlertView().showSuccess("Ajout Réussi", subTitle: "Votre élève a bien était enregistrer", closeButtonTitle: "Ok", duration: 5.0)
    }
    
    func validationFailed(errors:[UITextField:ValidationError]) {
        //  Validation FAILED
        self.setErrors()
    }
    
    private func setErrors(){
        for (field, error) in validator.errors {
            field.layer.borderColor = UIColor.redColor().CGColor
            field.layer.borderWidth = 1.0
            field.layer.cornerRadius = 5
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.hidden = false
        }
    }
    
    private func clearErrors(){
        for (field, error) in validator.errors {
            field.layer.borderColor = Constants.AppColor.CGColor
            error.errorLabel?.hidden = true
        }
    }
}
