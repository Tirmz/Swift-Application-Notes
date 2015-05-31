import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var l_moyenne: UILabel!
    @IBOutlet weak var tableViewNote: UITableView!
    @IBOutlet weak var b_add: UIButton!
    
    var eleve: Eleve = Eleve()
    
    // MARK: - override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        MesFonctions.convertButton([b_add])
        
        self.navigationItem.title = "Notes de " + eleve.prenom
    }
    
    
    override func viewWillAppear(animated: Bool) {
        eleve.APIgetMatieres()
        tableViewNote.reloadData()
        l_moyenne.text = String(MesFonctions.MoyenneGenerale(eleve.matieres))
    }
    
    // MARK: - TableView Function

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return eleve.matieres.count
    }
    
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
      return eleve.matieres[section].listeNote.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell: TVC_CustomSection = tableView.dequeueReusableCellWithIdentifier("cellSection") as! TVC_CustomSection
        
        cell.l_title.text = eleve.matieres[section].name
        cell.nbRow.text = String(eleve.matieres[section].listeNote.count)
        cell.section.tag = section
        
        return cell
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellType1") as! UITableViewCell
        
        cell.textLabel!.text = String(eleve.matieres[indexPath.section].listeNote[indexPath.row].nbPoint)
        cell.detailTextLabel!.text = String(eleve.matieres[indexPath.section].listeNote[indexPath.row].coefficient)
        
        return cell
    }

    // MARK: - Navigation Function

    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        if let VC: VC_Note = segue!.destinationViewController as? VC_Note
        {
            VC.eleve = eleve
            if let indexPath = tableViewNote.indexPathForSelectedRow() as NSIndexPath?
            {
                VC.indexOfNote = indexPath.row
            }
        }
        
        if let VC: VC_Matiere = segue!.destinationViewController as? VC_Matiere
        {
            VC.eleve = eleve
            if let button = sender as? UIButton
            {
                VC.IndexOfmatiere = button.tag
            }
        }
        
        if let VC: VC_AjoutMatiere = segue!.destinationViewController as? VC_AjoutMatiere
        {
            VC.DataNote = eleve.matieres
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
