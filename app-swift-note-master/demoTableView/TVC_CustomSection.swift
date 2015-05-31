//
//  TVC_SectionMatiereTableViewCell.swift
//  demoTableView
//
//  Created by userEPSI on 27/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class TVC_CustomSection: UITableViewCell {
   
    @IBOutlet weak var l_title: UILabel!

    @IBOutlet weak var nbRow: UILabel!
    var bl_retract = false
    
    @IBOutlet weak var section: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var simpleTape = UITapGestureRecognizer()
        simpleTape.delegate = self
        self.addGestureRecognizer(simpleTape)
        
        self.backgroundColor = Constants.AppColor
        nbRow.textColor = Constants.AppColor
        nbRow.layer.masksToBounds = true
        nbRow.layer.cornerRadius = 8.0
        //b_title.titleLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
