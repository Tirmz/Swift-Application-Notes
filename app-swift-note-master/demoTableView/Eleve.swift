import UIKit

class Eleve
    
{
    //MARK: - Attributs
    
    var id: Int
    var nom: String
    var prenom: String
    var email: String
    var photo: UIImage
    var date_naissance: NSDate
    var classe: Classe
    var notes: Array<Note>
    var matieres: Array<Matiere>
    
    //MARK: - Constructeurs
    init()
    {
        self.id = Int()
        self.nom = String()
        self.prenom = String()
        self.email = String()
        self.photo = UIImage()
        self.date_naissance = NSDate()
        self.classe = Classe()
        self.notes = Array<Note>()
        self.matieres = Array<Matiere>()
    }
    
    init(id: String, lastName: String, firstName: String, email: String, dateOfBirth: String, classe: Classe){
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // convert string into date
        let date:NSDate? = dateFormatter.dateFromString(dateOfBirth)
        
        self.id = id.toInt()!
        self.nom = lastName
        self.prenom = firstName
        self.email = email
        self.photo = UIImage()
        self.date_naissance = date!
        self.classe = classe
        self.notes = Array<Note>()
        self.matieres = Array<Matiere>()
    }
    
    init(lastName: String, firstName: String, email: String, dateOfBirth: String, classe: Classe){
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // convert string into date
        let date:NSDate? = dateFormatter.dateFromString(dateOfBirth)
        
        self.id = Int()
        self.nom = lastName
        self.prenom = firstName
        self.email = email
        self.photo = UIImage()
        self.date_naissance = date!
        self.classe = classe
        self.notes = Array<Note>()
        self.matieres = Array<Matiere>()
    }
    
    internal func APIAdd() {
        
        // Prepare data
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // convert string into date
        let date: String = dateFormatter.stringFromDate(self.date_naissance as NSDate)
        
        var bodyData = Dictionary<String, AnyObject>()
        bodyData = [
            "idClasse": self.classe.id,
            "firstName": self.prenom,
            "lastName": self.nom,
            "email": self.email,
            "dateOfBirth": date
        ]
        
        var body = NSJSONSerialization.dataWithJSONObject(bodyData, options: nil, error: nil)
        
        // Prepare request
        let url = NSURL(string: Constants.UrlApi + "/eleve")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    }
    
//    func APIgetEleve(id: Int){
//        
//        let url = NSURL(string: Constants.UrlApi + "/eleve/\(id)")!
//        
//        var request = NSMutableURLRequest(URL: url)
//        request.HTTPMethod = "GET"
//        
//        var response: NSURLResponse?
//        var error: NSError?
//        
//        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
//        
//        let jsonResult = MesFonctions.parseJSON(data!)
//        
//        if (data?.length != nil && data?.length != 0) {
//            
//            var eleves = jsonResult["eleves"] as! NSArray
//                
//            var eleve = Eleve(
//                id: eleves["id"] as! String,
//                lastName: eleves["lastName"] as! String,
//                firstName: eleves["firstName"] as! String,
//                email: eleves["email"] as! String,
//                dateOfBirth: eleves["dateOfBirth"] as! String,
//                classe: self
//            )
//        }
//    }
    
    internal func update() {
        
        // Prepare data
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
            // convert string into date
        let date: String = dateFormatter.stringFromDate(self.date_naissance as NSDate)
        
        var bodyData = Dictionary<String, AnyObject>()
        bodyData = [
            "idClasse": self.classe.id,
            "firstName": self.prenom,
            "lastName": self.nom,
            "email": self.email,
            "dateOfBirth": date
        ]
        
        var body = NSJSONSerialization.dataWithJSONObject(bodyData, options: nil, error: nil)
        
        // Prepare request
        let url = NSURL(string: Constants.UrlApi + "/eleve/\(self.id)")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        request.HTTPBody = body
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    }
    
    internal func delete() {
        let url = NSURL(string: Constants.UrlApi + "/eleve/\(self.id)")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "DELETE"
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    }
    
    internal func APIgetNotes(matiere: Matiere) {
        
        let url = NSURL(string: Constants.UrlApi + "/note")!
        
        var bodyFiltre = Dictionary<String, Dictionary<String, String>>()
        bodyFiltre = [
            "filtre" : [
                "idEleve": String(self.id)
            ]
        ]
        
        var body = NSJSONSerialization.dataWithJSONObject(bodyFiltre, options: nil, error: nil)
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        let jsonResult = MesFonctions.parseJSON(data!)
        
        var notes = jsonResult["notes"] as! NSArray
        
        for array in notes {
            let dico = array as! NSDictionary

            
            var dateFormatter : NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-YYYY"
            let date = dateFormatter.dateFromString(dico["date"] as! String)
            
            var note = Note(
                Id          : dico["id"] as! Int,
                NbPoint     : dico["nbPoints"] as! Int,
                Date        : date!,
                Description : dico["apreciation"] as! String,
                Coefficient : dico["coefficient"] as! Int,
                eleve       : self,
                matiere     : matiere
            )
            self.notes.append(note)
        }
    }
    
    func APIgetMatieres() {
        let url = NSURL(string: Constants.UrlApi + "/matiere")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        print(data?.length)
        
        if (data?.length != 0 && data?.length != nil) {
            
            let jsonResult = MesFonctions.parseJSON(data!)
            var matieres = jsonResult["matiere"] as! NSArray
            var listeMatiere = Array<Matiere>()
            
            for array in matieres {
                let dico = array as! NSDictionary

                var matiere = Matiere(
                    Id: dico["id"] as! Int,
                    Name: dico["name"] as! String,
                    Coefficient: dico["coefficient"] as! Int,
                    Description: dico["description"] as! String
                )
                matiere.APIGetNotesByEleveID(self)
                listeMatiere.append(matiere)
            }
            self.matieres = listeMatiere
        }
    }
}
