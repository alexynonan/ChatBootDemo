//
//  ViewController.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 1/20/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct Message {
    
    var publicacion = ""
    var fecha = ""
    var idPersona = ""
}

class ViewController: UIViewController {
    
    @IBOutlet weak var txtMessage : UITextField!
    @IBOutlet weak var tblPubliacaciones : UITableView!
    @IBOutlet weak var constraintCentroLogin: NSLayoutConstraint!
    
    var valorIniciarConstraintFormulario : CGFloat?
    var publicacionesRef : DatabaseReference!
    let dateFormatter = DateFormatter()
    var arrayPruebas = [Message]()
    var usuario = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblPubliacaciones.addSubview(self.refreshControl)
        self.listMessage()
        
//        self.valorIniciarConstraintFormulario = self.constraintCentroLogin.constant
        // Do any additional setup after loading the view.
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func openAlert(){
        let alert = UIAlertController(title: "HOLA }:)", message: "Ingresa tu Usuario", preferredStyle: .alert)
        alert.addTextField { (texfield) in
            texfield.textColor = .darkGray
            texfield.placeholder = "Usuario"
        }
        let butonCancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        let aletOk = UIAlertAction(title: "OK", style: .default) { (action) in
            if let name = alert.textFields?.first?.text{
                self.usuario = name
            }
        }
        alert.addAction(aletOk)
        alert.addAction(butonCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.openAlert()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
        super.viewWillDisappear(animated)
    }
    
    lazy var refreshControl : UIRefreshControl! = {
        var objRefresh = UIRefreshControl()

        objRefresh.tintColor = UIColor.black
        objRefresh.addTarget(self, action: #selector(self.listMessage), for: .valueChanged)
        return objRefresh
    }()
    
    @objc func listMessage(){
        self.refreshControl.beginRefreshing()
        self.publicacionesRef = Database.database().reference(withPath: "messages")
        
            self.publicacionesRef.observe(DataEventType.value, with: { (array) in
                    self.refreshControl.endRefreshing()
                    self.arrayPruebas.removeAll()
            
                    for arrayList in array.children.allObjects as! [DataSnapshot]{
                        
                        let menssage = arrayList.value as? [String : AnyObject]
                        
                        let mensaje = menssage?["message"]
                        let fechas = menssage?["sender"]
                        let idPersona = menssage?["idPersona"]
                        
                        self.arrayPruebas.append(Message(publicacion: mensaje as? String ?? "", fecha: fechas as? String ?? "", idPersona: idPersona as? String ?? ""))
                        self.tblPubliacaciones.reloadData()
                        
                        if self.arrayPruebas.count != 0{
                            let indice = IndexPath.init(row: self.arrayPruebas.count - 1, section: 0)
                            self.tblPubliacaciones.scrollToRow(at: indice, at: .top, animated: true)
                        }
                    }
                }) { (errorMessage) in
                    self.refreshControl.endRefreshing()
                    self.showAltert(withTitle: "Mapsalud", withMessage: errorMessage.localizedDescription, withAcceptButton: "Aceptar", withCompletion: nil)
                }
        
    }
    
    func agregar(){
        
        dateFormatter.dateFormat = "HH:mm"
        let hora = dateFormatter.string(from: NSDate() as Date)
        
        
        self.publicacionesRef = Database.database().reference().child("messages").childByAutoId()
        
        let dic : [String : Any] = ["sender" : "\(self.usuario)",
                                    "message" : self.txtMessage.text!,
                                    "like" : 0,
                                     "fecha" : hora]
        self.txtMessage.text = ""
        self.publicacionesRef.setValue(dic)
        
    }
    
    @IBAction func btnAgregar(_ sender : UIButton!){
        self.agregar()
    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayPruebas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        
        cell.objMessage = self.arrayPruebas[indexPath.row]
        return cell
    }
    
}
//
//extension ViewController{
//
//    @objc func keyboardWillShown(notification : NSNotification) -> Void{
//
//        let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
//
//        let finalFormulario = self.tblPubliacaciones.frame.size.height / 2 + self.valorIniciarConstraintFormulario!
//        let tamanoPantalla = UIScreen.main.bounds.size.height / 2
//        let areaDisponible = tamanoPantalla - (kbSize?.height)!
//
//        if finalFormulario > areaDisponible {
//
//            UIView.animate(withDuration: 0.35, animations: {
//
//                self.constraintCentroLogin.constant = self.valorIniciarConstraintFormulario! - (finalFormulario - areaDisponible) - 2
//                self.view.layoutIfNeeded()
//            })
//
//        }
//    }
//
//
//    @objc func keyboardWillBeHidden(notification : NSNotification) -> Void {
//
//        UIView.animate(withDuration: 0.35, animations: {
//
//            self.constraintCentroLogin.constant = self.valorIniciarConstraintFormulario!
//            self.view.layoutIfNeeded()
//        })
//    }
//}
