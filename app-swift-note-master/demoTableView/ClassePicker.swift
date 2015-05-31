//
//  ClassePicker.swift
//  demoTableView
//
//  Created by Léo on 28/04/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import UIKit

class ClassePicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var classeListe = Array<Classe>()

    // MARK: - UIPicker implementation
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func numberOfComponentsInPickerView(_: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classeListe.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return classeListe[row].nom
    }

}
