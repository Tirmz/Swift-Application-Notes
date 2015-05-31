//
//  SettingViewControllerTableViewController.swift
//  demoTableView
//
//  Created by userEPSI on 21/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class SettingViewControllerTableViewController: UITableViewController, UIAlertViewDelegate {

    var DataNote: Array<Matiere> = []
    var IndexOfClikedCell: NSIndexPath = NSIndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
        
        return 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("celluleTypeSetting") as! UITableViewCell
        
        if indexPath.row == 0
        {
            cell.textLabel!.text = "supprimer la note"
        }
        else if indexPath.row == 1
        {
            cell.textLabel!.text = "modifier la note"
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == 0)
        {
            var alertView = UIAlertView()
            alertView.delegate = self
            alertView.addButtonWithTitle("Oui")
            alertView.addButtonWithTitle("Non")
            alertView.title = "Supprimer";
            alertView.message = "Etes vous certain de vouloir supprimer cette note ?";
            alertView.show()
            
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(alertView.title == "Supprimer")
        {
            switch buttonIndex
                {
            case 0:
                DataNote[IndexOfClikedCell.section].listeNote.removeAtIndex(IndexOfClikedCell.row)
                
            default:
                println("annulé")
                
            }
        }
    }
    
    
    
    func OnClickCell(message: String)
    {
        var alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        //alert.addAction(UIAlertAction(title: "OnClickCell", style: UIAlertActionStyle.Default, handler: nil))
        //self.presentViewController(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                println("default")
                
            case .Cancel:
                println("cancel")
                
            case .Destructive:
                println("destructive")
            }
        }))
    }
    

}
