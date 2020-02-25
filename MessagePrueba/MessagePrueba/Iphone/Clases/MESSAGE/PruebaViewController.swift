//
//  PruebaViewController.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 2/21/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit

class PruebaViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var txfNOmbres : UITextField!
    @IBOutlet weak var lblDatos : UILabel!
    
    var labelFinal = UILabel()

    var informacion = "kjasbdabd kjasdkabsdhjas aksbdhasbjdk  alexander@gmail.com laksbhjcvasgc laksndlnasd dsaknlsdkl http://desappstre.com/como-se-hace-esto-en-un-string-de-swift/  akdbjavdvasyudvyuasvdas 987677106   https://www.hackingwithswift.com "
    
    var arrayNombres  = ["Alexander", "Brenda" , "Natalia", "Johel"]
    var selectedPriority : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addUITextViews()
        self.exitPicker()
  
    }
    
    func addUITextViews(){
        var objPicker = UIPickerView()
        objPicker.delegate = self
        self.txfNOmbres.inputView = objPicker
    }
    
    func exitPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.dismissKeyBoard))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        self.txfNOmbres.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyBoard(){
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrayNombres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.arrayNombres[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPriority = self.arrayNombres[row]
        self.txfNOmbres.text = selectedPriority
    }
}

