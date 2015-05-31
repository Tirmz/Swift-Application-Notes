//
//  LengthRule.swift
//  Validator
//
//  Created by Jeff Potter on 3/6/15.
//  Copyright (c) 2015 jpotts18. All rights reserved.
//

import Foundation


class MinLengthRule : Rule {
    
    let DEFAULT_MIN_LENGTH:Int = 3
    
    init(){}

    
    func errorMessage() -> String {
        return "Must be at least \(DEFAULT_MIN_LENGTH) characters long"
    }
    
    func validate(value: String) -> Bool {
        if count(value) <= DEFAULT_MIN_LENGTH {
            return false
        }
        return true
    }
}