import UIKit

class VC_Eleves: UIViewController, UIAlertViewDelegate, ValidationDelegate {
    
    var classeListe = Array<Classe>()
    var classe = Classe()
    var indexOfEleve = Int()
    var indexOfClasse = 0
    var eleveWasUpdated = Bool()
    
    let validator = Validator()
    var validationSuccess = Bool()
    
    var datePicker = UIDatePicker()
    var classePicker = ClassePicker()
    
    var textField = UITextField()
    
    // MARK: - Data Outlet
    // label
    @IBOutlet weak var l_lastName: UILabel!
    @IBOutlet weak var l_verifLastName: UILabel!
    @IBOutlet weak var l_verifFirstName: UILabel!
    @IBOutlet weak var l_firstName: UILabel!
    @IBOutlet weak var l_email: UILabel!
    @IBOutlet weak var l_verifEmail: UILabel!
    @IBOutlet weak var l_dateOfBirth: UILabel!
    @IBOutlet weak var l_classe: UILabel!
    
    //button
    @IBOutlet weak var b_lastName: UIButton!
    @IBOutlet weak var b_firstName: UIButton!
    @IBOutlet weak var b_email: UIButton!
    @IBOutlet weak var b_dateOfBirth: UIButton!
    @IBOutlet weak var b_classe: UIButton!
    @IBOutlet weak var b_see: UIButton!
    @IBOutlet weak var b_delete: UIButton!
    @IBOutlet weak var b_nextEleve: UIButton!
    @IBOutlet weak var b_precedentEleve: UIButton!
    
    var buttons = Array<UIButton>()
    
    // MARK: - Init Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(classe.listeEleve.count > 0) {
            setDisplayEleve()
        } else {
            navigationController?.popViewControllerAnimated(true)
        }
        
        buttons = [
            b_lastName,
            b_firstName,
            b_email,
            b_dateOfBirth,
            b_classe,
            b_see,
            b_delete,
            b_nextEleve,
            b_precedentEleve
        ]
        
        MesFonctions.convertButton(buttons)
        
        getClasses()

        // Do any additional setup after loading the view.
    }
    
    func setDisplayEleve()
    {
        // Display Labels
        var date = classe.listeEleve[indexOfEleve].date_naissance
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        var dateString = dateFormatter.stringFromDate(date)
        
        l_lastName.text = classe.listeEleve[indexOfEleve].nom
        l_lastName.backgroundColor = Constants.AppColor
        l_lastName.layer.masksToBounds = true
        l_lastName.layer.cornerRadius = 5
        
        l_firstName.text = classe.listeEleve[indexOfEleve].prenom
        l_email.text = classe.listeEleve[indexOfEleve].email
        l_dateOfBirth.text = dateString
        l_classe.text = classe.nom
        
        // Display buttons
        if(indexOfEleve == 0) {
            b_precedentEleve.hidden = true
        } else {
            b_precedentEleve.hidden = false
        }
        if(indexOfEleve == classe.listeEleve.count - 1) {
            b_nextEleve.hidden = true
        } else {
            b_nextEleve.hidden = false
        }
    }
    
    // MARK: - Update function implementation
    func updateEleve(){
        if (eleveWasUpdated == true) {
            classe.listeEleve[indexOfEleve].update()
            eleveWasUpdated == false
        }
    }
    
    func updateLastName() {
        let newName = textField.text
        self.clearErrors(l_verifLastName)
        validator.validateAll(self)
        
        if(validationSuccess == true) {
            classe.listeEleve[indexOfEleve].nom = newName
            l_lastName.text = newName
            eleveWasUpdated = true
            validationSuccess = false
        }
        validator.clearValidation()
        validator.clearErrors()
    }
    
    @IBAction func updateLastName(sender: AnyObject) {
        
        let alert = SCLAlertView()
        
        let txt = alert.addTextField(title:"Entrer le nom")
        self.textField = txt
        
        validator.registerField(
            textField: textField,
            errorLabel: l_verifLastName,
            rules: [
                RequiredRule()
            ])
        
        alert.addButton("Remplacer") {
            self.updateLastName()
        }
        alert.showEdit("Modifier", subTitle:"Modifier le nom de l'élève")
    }
    
    func updateFirstName() {
        let newName = textField.text
        self.clearErrors(l_verifFirstName)
        validator.validateAll(self)
        
        if(validationSuccess == true) {
            classe.listeEleve[indexOfEleve].prenom = newName
            l_firstName.text = newName
            eleveWasUpdated = true
            validationSuccess = false
        }
        validator.clearValidation()
        validator.clearErrors()
    }
    
    @IBAction func updateFirstName(sender: AnyObject) {
        
        let alert = SCLAlertView()
        
        let txt = alert.addTextField(title:"Entrer le prénom")
        self.textField = txt
        
        validator.registerField(
            textField: textField,
            errorLabel: l_verifFirstName,
            rules: [
                RequiredRule()
            ])
        
        alert.addButton("Remplacer") {
            self.updateFirstName()
        }
        alert.showEdit("Modifier", subTitle:"Modifier le Prénom de l'élève")
    }
    
    func updateEmail() {
        let email = textField.text
        self.clearErrors(l_verifEmail)
        validator.validateAll(self)
        
        if(validationSuccess == true) {
            classe.listeEleve[indexOfEleve].email = email
            l_email.text = email
            eleveWasUpdated = true
            validationSuccess = false
        }
        validator.clearValidation()
        validator.clearErrors()
    }
    
    @IBAction func updateEmail(sender: AnyObject) {
        
        let alert = SCLAlertView()
        
        let txt = alert.addTextField(title:"Entrer l'email")
        self.textField = txt
        
        validator.registerField(
            textField: textField,
            errorLabel: l_verifEmail,
            rules: [
                RequiredRule()
            ])
        
        alert.addButton("Remplacer") {
            self.updateEmail()
        }
        alert.showEdit("Modifier", subTitle:"Modifier l'email de l'élève")
    }
    
    func updateDateOfBirth() {
        let date = datePicker.date
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        l_dateOfBirth.text = dateFormatter.stringFromDate(date)
        classe.listeEleve[indexOfEleve].date_naissance = date
        eleveWasUpdated = true
    }
    
    @IBAction func updateDateOfBirth(sender: AnyObject) {
        
        var datePickerOfbirth = UIDatePicker(frame: CGRectMake(-8, 180, 300, 300))
        datePickerOfbirth.datePickerMode = UIDatePickerMode.Date
        
        datePicker = datePickerOfbirth

        let alert = SCLAlertView()
        
        alert.kWindowWidth += 50
        alert.kWindowHeight += 200
        
        alert.labelTitle.frame.origin.x += 25
        
        alert.contentView.addSubview(datePickerOfbirth)
        alert.addButton("Remplacer") {
            self.updateDateOfBirth()
        }
        
        alert.showEdit("Modifier", subTitle:"Modifier la date de naissance de l'élève")
    }
    
    func updateClasse() {
        indexOfClasse = classePicker.selectedRowInComponent(0)
        l_classe.text = classeListe[indexOfClasse].nom
        classe.listeEleve[indexOfEleve].classe = classeListe[indexOfClasse]
        eleveWasUpdated = true
    }
    
    @IBAction func updateClasse(sender: AnyObject) {
        
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
        alert.addButton("Remplacer") {
            self.updateClasse()
        }
        
        alert.showEdit("Modifier", subTitle:"Modifier la classe de l'élève")
    }
    
    func deleteEleve() {
        classe.listeEleve[indexOfEleve].delete()
        classe.listeEleve.removeAtIndex(indexOfEleve)
        if (classe.listeEleve.count == indexOfEleve) {
            indexOfEleve--
        }
        viewDidLoad()
    }
    
    // MARK: - Navigation Eleves
    
    @IBAction func deteteEleve(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.addButton("Supprimer") {
            self.deleteEleve()
        }
        alert.showWarning("Supprimer", subTitle:"Si vous supprimer l'élèves ses notes seront également supprimé")
    }
    
    @IBAction func getNextEleve(sender: AnyObject) {
        updateEleve()
        indexOfEleve++
        self.viewDidLoad()
    }
    
    @IBAction func getBackEleve(sender: AnyObject) {
        updateEleve()
        indexOfEleve--
        self.viewDidLoad()
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
    
    // MARK: - Api Rest Request
    
    internal func getClasses(){
        
        let url = NSURL(string: Constants.UrlApi + "/classe")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        let jsonResult = MesFonctions.parseJSON(data!)
        
        var classes = jsonResult["classe"] as! NSArray
        
        for array in classes {
            let dico = array as! NSDictionary
            var classe = Classe(classe: dico)
            self.classeListe.append(classe)
        }
    }
    
    // MARK: - View change
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        if let VC = segue!.destinationViewController as? ViewController {
            if let bt_section = sender as? UIButton {
                VC.eleve = classe.listeEleve[indexOfEleve]
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
            updateEleve()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
