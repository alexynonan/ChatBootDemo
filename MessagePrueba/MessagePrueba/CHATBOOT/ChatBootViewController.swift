//
//  ChatBootViewController.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 2/12/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit
import Firebase
import ApiAI
import AVFoundation
import MessageUI

struct BootBE {
    var respuesta  = ""
    var sender  = ""
    var id = 0
}

class ChatBootViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtMessage : UITextField!
    @IBOutlet weak var tblBoot : UITableView!
    @IBOutlet weak var bottomScroll: NSLayoutConstraint!
    
    @IBOutlet weak var vistaFormulario : UIView!
    
    var respuestaMessage : String!
    var arrayBoot = [BootBE]()
    var refBoot : DatabaseReference!
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var valorIniciarConstraintFormulario : CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblBoot.addSubview(self.refreshControll)
        self.listarChatBoot()

        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.txtMessage.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapCerrarTeclado(_ sender: AnyObject?) {
        self.view.endEditing(true)
    }
    
    lazy var refreshControll : UIRefreshControl! = {
       
        var objRefreshControll = UIRefreshControl()
        objRefreshControll.backgroundColor = .clear
        objRefreshControll.tintColor = .darkGray
        objRefreshControll.addTarget(self, action: #selector(self.listarChatBoot), for: .valueChanged)
        return objRefreshControll
    }()
    
    @objc func listarChatBoot(){
        self.refreshControll.beginRefreshing()
        self.refBoot = Database.database().reference(withPath: "chatBootBeta5")
    
        self.refBoot.observe(DataEventType.value, with: { (array) in
                self.refreshControll.endRefreshing()
                self.arrayBoot.removeAll()
            
                for arrayList in array.children.allObjects as! [DataSnapshot]{
                    
                    let menssage = arrayList.value as? [String : AnyObject]
                    
                    let respuesta = menssage?["respuesta"]
                    let sender = menssage?["sender"]
                    let id = menssage?["id"]
                    
                    self.arrayBoot.append(BootBE(respuesta: respuesta as! String , sender: sender as! String , id : id as! Int))
                    self.tblBoot.reloadData()
                    
                    if self.arrayBoot.count != 0{
                        let indice = IndexPath.init(row: self.arrayBoot.count - 1, section: 0)
                        self.tblBoot.scrollToRow(at: indice, at: .top, animated: true)
                    }
                }
            
            }) { (errorMessage) in
                self.refreshControll.endRefreshing()
                self.showAltert(withTitle: "Mapsalud", withMessage: errorMessage.localizedDescription, withAcceptButton: "Aceptar", withCompletion: nil)
            }
    }
 
    @IBAction func btnEnviar(){
        
        let request = ApiAI.shared().textRequest()

        if let text = self.txtMessage.text, text != "" {
            self.view.isUserInteractionEnabled = false
            self.agregarUsuario(text)
            request?.query = text
        } else {
            return
        }
        
//        request?.setCompletionBlockSuccess({ (request, response) in
//            print(request?.response)
//            let response = request?.response as! AIResponse
//
//            if let textResponse = response.result.fulfillment.speech {
//                self.speechAndText(text: textResponse)
//            }
//        }, failure: { (request, error) in
//            print(error!)
//        })
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in

            print(request?.response)

            let response = response as! AIResponse

            if let textResponse = response.result.fulfillment.speech {
                self.speechAndText(text: textResponse)
            }else{
                print("fallo")
            }
        }, failure: { (request, error) in
            print(error!)
        })
        
        ApiAI.shared().enqueue(request)
        self.txtMessage.text = ""
        
    }
     
    func speechAndText(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
        self.agregarBoot(text)
        self.view.isUserInteractionEnabled = true
        print(text)
    }
        
    func agregarBoot(_ respuesta : String){
    
        self.refBoot = Database.database().reference().child("chatBootBeta5").childByAutoId()
        
        let dic : [String : Any] = ["respuesta" : "\(respuesta)",
                                    "sender" : "Boot",
                                    "id" : 0]

        self.refBoot.setValue(dic)
    }
    func agregarUsuario(_ respuesta : String){
    
        self.refBoot = Database.database().reference().child("chatBootBeta5").childByAutoId()
        
        let dic : [String : Any] = ["respuesta" : "\(respuesta)",
                                    "sender" : "cliente",
                                    "id" : 1]

        self.refBoot.setValue(dic)
    }
    
    @objc func keyBoardWillShow(notification: Notification){
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject>{
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.bottomScroll.constant = keyBoardHeight 
                UIView.animate(withDuration: 0.1, animations: {
                    self.view.layoutIfNeeded()
                    
                    if self.arrayBoot.count != 0{
                    let indice = IndexPath.init(row: self.arrayBoot.count - 1, section: 0)
                    self.tblBoot.scrollToRow(at: indice, at: .top, animated: true)
                    }
                })
            }
        }
    }
    
    @objc func keyBoardWillHide(notification: Notification){
        
        self.bottomScroll.constant = 0
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

extension ChatBootViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayBoot.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let obj = self.arrayBoot[indexPath.row]
        let cellIdentifier = obj.id == 1 ? "ChatBootTableViewCell" : "ChatBootTableViewCell2"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ChatBootTableViewCell
        cell.objBoot = obj
        return cell
    }
    
}
