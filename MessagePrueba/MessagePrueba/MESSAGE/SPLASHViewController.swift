//
//  SPLASHViewController.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 1/21/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit
import FirebaseAuth

class SPLASHViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser == nil{
            self.performSegue(withIdentifier: "ViewController", sender: nil)
        }else{
            self.performSegue(withIdentifier: "LoginViewController", sender: nil)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
