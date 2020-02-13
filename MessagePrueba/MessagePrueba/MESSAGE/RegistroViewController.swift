//
//  RegistroViewController.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 1/21/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
class RegistroViewController: UIViewController {
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtContraseña: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var cargarActivity : UIActivityIndicatorView!
    
    var publiacacionRef : DatabaseReference!
    var userData : Auth!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnRegistrar(_ sender: UIButton) {
        
        Auth.auth().createUser(withEmail: self.txtCorreo.text!, password: self.txtContraseña.text!) { (resultado, error) in
            
            if resultado != nil{
                
                self.publiacacionRef = Database.database().reference().child("Usuarios").childByAutoId()
                
                let estrucutura : [String : Any] = ["nombre" : self.txtNombre.text!,
                                                    "apellido" : self.txtApellido.text! as String,
                                                    "correo" : self.txtCorreo.text! as String]
                self.cargarActivity.stopAnimating()
                self.publiacacionRef.setValue(estrucutura)
           
                self.showAltert(withTitle: "Felicidades", withMessage: "Ya Formas Parte de Insta Isil !! 🎉", withAcceptButton: "Gracias 😁") {
                    self.txtNombre.text! = ""
                    self.txtApellido.text! = ""
                    self.txtContraseña.text! = ""
                    self.txtCorreo.text! = ""
                   
                    //animacion de transision hacia el costado
                    self.navigationController?.popViewController(animated: true)
                }
                
            }else{
                self.cargarActivity.stopAnimating()
                self.showAltert(withTitle: "Vaya!", withMessage: error!.localizedDescription, withAcceptButton: "Okey") {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        }
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
