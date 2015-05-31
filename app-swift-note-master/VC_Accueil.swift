//
//  VC_Accueil.swift
//  demoTableView
//
//  Created by Léo on 03/05/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import UIKit

class VC_Accueil: UIViewController {

    @IBOutlet weak var b_setting: UIButton!
    @IBOutlet weak var b_start: UIButton!
    
    var buttons = Array<UIButton>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAppColor()
        
        buttons.append(b_setting)
        buttons.append(b_start)
        
        setDisplay()
    }
    
    func setDisplay() {
        self.navigationController!.navigationBar.tintColor = Constants.AppColor
    }
    
    override func viewWillAppear(animated: Bool) {
       setDisplay()
        MesFonctions.convertButton(buttons)
    }

    
    @IBAction func settingAction(sender: AnyObject) {
        
        let alert = SCLAlertView()
        
        alert.addButton("Vert") {
            self.saveColor("vert")
            self.checkAppColor()
            self.viewWillAppear(true)
        }
        alert.addButton("Bleu") {
            self.saveColor("bleu")
            self.checkAppColor()
            self.viewWillAppear(true)
        }
        alert.addButton("Orange") {
            self.saveColor("orange")
            self.checkAppColor()
            self.viewWillAppear(true)
        }
        alert.addButton("Noir") {
            self.saveColor("noir")
            self.checkAppColor()
            self.viewWillAppear(true)
        }
        alert.addButton("Rose") {
            self.saveColor("rose")
            self.checkAppColor()
            self.viewWillAppear(true)
        }
        
        alert.showEdit("Paramètre", subTitle:"Selectionnez la couleur de l'application")
        
        (alert.contentView.subviews[2] as! UIButton).backgroundColor =  UIColor(red: 0, green: 153/255, blue: 0, alpha: 1.0)
        
        (alert.contentView.subviews[3] as! UIButton).backgroundColor = UIColor(red: 0, green: 51/255, blue: 1, alpha: 1)
        
        (alert.contentView.subviews[4] as! UIButton).backgroundColor = UIColor(red: 223/255, green: 110/255, blue: 0, alpha: 1)
        
        (alert.contentView.subviews[5] as! UIButton).backgroundColor = UIColor.blackColor()
        
        (alert.contentView.subviews[6] as! UIButton).backgroundColor = UIColor(red: 1, green: 40/255, blue: 1, alpha: 1)
    }
    
    func saveColor(color: String) {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(color, forKey: "colorApp")
        userDefaults.synchronize()
    }
    
    func checkAppColor() {
        if let color = NSUserDefaults.standardUserDefaults().valueForKey("colorApp") as? String {
            switch color {
                
            case "vert":
                Constants.AppColor = UIColor(red: 0, green: 153/255, blue: 0, alpha: 1.0)
                break
                
            case "bleu":
                Constants.AppColor = UIColor(red: 0, green: 51/255, blue: 1, alpha: 1)
                break
                
            case "orange":
                Constants.AppColor = UIColor(red: 223/255, green: 110/255, blue: 0, alpha: 1)
                break
                
            case "noir":
                Constants.AppColor = UIColor.blackColor()
                break
                
            case "rose":
                Constants.AppColor = UIColor(red: 1, green: 40/255, blue: 1, alpha: 1)
                break
                
            default:
                Constants.AppColor = UIColor(red: 0, green: 153/255, blue: 0, alpha: 1.0)
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
