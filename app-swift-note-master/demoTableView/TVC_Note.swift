//
//  TVC_Note.swift
//  demoTableView
//
//  Created by userEPSI on 29/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class TVC_Note: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    var selection: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func clickSelector(sender: UIButton) {
        
        if(selection == false)
        {
            var backImg: UIImage = UIImage(named: "white65.png")!
            sender.setBackgroundImage(backImg, forState: nil)
            
            selection = true
        }
        else
        {
            var backImg: UIImage = UIImage(named: "Cercle_noir.png")!
            sender.setBackgroundImage(backImg, forState: nil)
            
            selection = false
        }
        
    }
}
