//
//  CMPSChatBotBC.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 2/21/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit

class CMPSChatBotBC: NSObject {
    
    class func getChatString(_ mensageVacio : String, _ errorMessage : @escaping ErrorMessage){
        
        if mensageVacio != ""{
            CMPSChatBotWS.getChatString(mensageVacio,errorMessage)
        }else{
            errorMessage("Escriba su pregunta ...")
        }
    }
    
}
