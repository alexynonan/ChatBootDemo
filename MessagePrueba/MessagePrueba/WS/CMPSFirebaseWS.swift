//
//  CMPSFirebaseWS.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 2/24/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit
import Firebase

class CMPSFirebaseWS: NSObject {
    
    typealias CompletionBoot = (_ array : [CMPSBotBE]) -> Void
    
    public static var firebaseBoot = Database.database().reference()
    
    class func getDatosChatBoot(_ completion : @escaping CompletionBoot,_ errorMessage : @escaping ErrorMessage){
        
        firebaseBoot.child("chatBootBeta5").observe(DataEventType.value, with: { (arrayData) in
            
                var arrayBoot = [CMPSBotBE]()
                
                for arrayList in arrayData.children{
                    if let arrayFinal = arrayList as? DataSnapshot, let dic = arrayFinal.value as? [String : Any]{
                        
                        arrayBoot.append(CMPSBotBE.parse(dic))
                    }
                }
                
                completion(arrayBoot)
            
        }) { (messageError) in
            errorMessage(messageError.localizedDescription)
        }
        
    
        
    }
    
    class func enviarDatoCliente(_ pregunta : String!,_ errorMessage : @escaping ErrorMessage){
        
        if let preguntaEnvia : String = pregunta{
            
            let dic : [String : Any] = ["respuesta" : preguntaEnvia,
                                        "sender" : "Cliente",
                                        "id" : 1]

            firebaseBoot.child("chatBootBeta5").childByAutoId().setValue(dic)
        }else{
            errorMessage("Problemas con la pregunta del Cliente")
        }
    }
    
    class func enviarDatoBot(_ pregunta : String!,_ errorMessage : @escaping ErrorMessage){
    
        if let preguntaEnvia : String = pregunta{
            
            let dic : [String : Any] = ["respuesta" : preguntaEnvia,
                                        "sender" : "GDH",
                                        "id" : 0]

            firebaseBoot.child("chatBootBeta5").childByAutoId().setValue(dic)
        }else{
            errorMessage("Problemas con la pregunta del Boot")
        }
        
       
    }

}
