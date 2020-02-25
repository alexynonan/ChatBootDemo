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

class ChatBootViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtMessage : UITextField!
    @IBOutlet weak var tblBoot : UITableView!
    @IBOutlet weak var bottomScroll: NSLayoutConstraint!
    
    @IBOutlet weak var vistaFormulario : UIView!
    
    var respuestaMessage : String!
    var arrayBoot = [CMPSBotBE]()
    var refBoot : DatabaseReference!
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var valorIniciarConstraintFormulario : CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblBoot.addSubview(self.refreshControll)
        self.listarChatBoot()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func tapCerrarTeclado(_ sender: AnyObject?) {
        self.view.endEditing(true)
    }
    
    lazy var refreshControll : UIRefreshControl! = {
       
        var objRefreshControll = UIRefreshControl()
        objRefreshControll.backgroundColor = .clear
        objRefreshControll.tintColor = .darkGray
        objRefreshControll.addTarget(self, action: #selector(self.listarChatBoot), for: .valueChanged)
        objRefreshControll.attributedTitle = NSAttributedString(string: "Espere Porfavor ...")
        return objRefreshControll
    }()
    
    @objc func listarChatBoot(){
        self.refreshControll.beginRefreshing()
        CMPSFirebaseWS.getDatosChatBoot({ (array) in
            self.refreshControll.endRefreshing()
            self.arrayBoot = array
            self.tblBoot.reloadData()
            
            if self.arrayBoot.count != 0{
                let indice = IndexPath.init(row: self.arrayBoot.count - 1, section: 0)
                self.tblBoot.scrollToRow(at: indice, at: .top, animated: true)
            }
            
        }) { (errorMessage) in
            self.refreshControll.endRefreshing()
            self.showAltert(withTitle: "Mapsaludo", withMessage: errorMessage, withAcceptButton: "Aceptar", withCompletion: nil)
        }

    }
 
    @IBAction func btnEnviar(){
        
        CMPSChatBotBC.getChatString(self.txtMessage.text!) { (errorMessage) in
            self.showAltert(withTitle: "UPS!", withMessage: errorMessage, withAcceptButton: "Aceptar", withCompletion: nil)
        }
        self.txtMessage.text = ""
    }
    
/**
     Funcion para que responda con Voz
*/
    func speechAndText(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
    }
        
    @objc func keyBoardWillShow(notification: Notification){
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject>{
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.bottomScroll.constant = keyBoardHeight - self.vistaFormulario.frame.height - self.vistaFormulario.frame.height
                
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
