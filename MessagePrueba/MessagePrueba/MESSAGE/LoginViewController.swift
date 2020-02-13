//
//  LoginViewController.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 1/21/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtCorreo : UITextField!
    @IBOutlet weak var txtPassword : UITextField!

    var utente = Auth.auth()
    var email = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.utente = Auth.auth().addStateDidChangeListener({ (Auth, user) in
//            if user?.email == self.email{
//                self.performSegue(withIdentifier: "ViewController", sender: nil)
//            }else{
//                print("NO INICIO")
//            }
//        }) as! Auth
    }

    @IBAction func btnIngresar(_ sender : UIButton!){
//        Auth.auth().signIn(withEmail: self.txtCorreo.text!, password: self.txtPassword.text!) { (result, error) in
//
//            if result != nil{
//                self.email = result?.user.email ?? ""
//                print(self.email )
//               result?.user.getIDTokenResult(completion: { (result, errorMessage) in
                    
//                print("\(result?.token)")
//                print("\(result?.signInProvider)")
//                print("\(result?.expirationDate)")
//                print("\(result?.issuedAtDate)")
//                print("\(result?.claims)")
//                print(errorMessage)
//               })
                self.performSegue(withIdentifier: "ViewController", sender: nil)
//            }else{
//                self.showAltert(withTitle: "Mapsalud", withMessage: error!.localizedDescription, withAcceptButton: "Aceptar", withCompletion: nil)
//            }
//        }
    }

}
