//
//  textoDelegate.swift
//  meme1
//
//  Created by Felix Canaparro on 22/11/2017.
//  Copyright © 2017 Felix Canaparro. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var isDefaultText: Bool = true
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       if isDefaultText {
            if (textField.text=="SUPERIOR"){
               textField.text=""
            }else if(textField.text=="INFERIOR"){
               textField.text=""
    }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
