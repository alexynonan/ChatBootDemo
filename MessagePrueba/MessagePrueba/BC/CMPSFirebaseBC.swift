//
//  CMPSFirebaseBC.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 2/24/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit

class CMPSFirebaseBC: NSObject {
    
    class func getQuestionUser(_ mensageVacio : String, _ errorMessage : @escaping ErrorMessage){
        
        if mensageVacio == ""{
            errorMessage("Problemas ")
        }else{
        
            CMPSFirebaseWS.enviarDatoCliente(mensageVacio, errorMessage)
        }
        
    }
    
    class func getQuestionBot(_ mensageVacio : String, _ errorMessage : @escaping ErrorMessage){
        
        if mensageVacio == ""{
            errorMessage("Problamas")
        }else{
            CMPSFirebaseWS.enviarDatoBot(mensageVacio, errorMessage)
        }
        
    }

}
