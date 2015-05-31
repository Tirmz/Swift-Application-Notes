//
//  MatierePicker.swift
//  demoTableView
//
//  Created by Léo on 02/05/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import UIKit

class MatierePicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    var matiereList = Array<Matiere>()
    
    // MARK: - UIPicker implementation
    
    func pickerView(_: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func numberOfComponentsInPickerView(_: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return matiereList.count
    }
    
    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return matiereList[row].name
    }
}
