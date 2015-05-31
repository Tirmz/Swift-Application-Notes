//
//  RootViewController.swift
//  demoTableView
//
//  Created by userEPSI on 30/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class Root: UINavigationController {
    
    var DataNote = Array<Matiere>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DataNote = MesFonctions.InitTestData()

        // Do any additional setup after loading the view.
    }

    func setNotes(data: Array<Matiere>)
    {
        DataNote = data
    }
    
   /* override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        if let VC: AccueilVC = segue!.destinationViewController as? AccueilVC
        {
            VC.DataNote = DataNote
        }
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
