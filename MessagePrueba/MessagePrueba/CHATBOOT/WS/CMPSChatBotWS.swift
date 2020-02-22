//
//  CMPSChatBotWS.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 2/21/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit
import ApiAI

typealias Completion = (_ resultado : String) -> Void
typealias ErrorMessage = (_ errorMessage : String) -> Void

class CMPSChatBotWS: NSObject {

    class func getChatString(_ mensageVacio : String, _ completion : @escaping Completion, _ errorMessage : @escaping ErrorMessage){
        
        let refApiAi = ApiAI.shared()?.textRequest()
        
        if let response = refApiAi?.setCompletionBlockSuccess({ (request, result) in
            
            let requestText = request?.response as! AIResponse
            
            if let textResponse = requestText.result.fulfillment.speech {
                
                completion(textResponse.description)
            }else{
                errorMessage(mensageVacio)
            }
            
        }, failure: { (request, result) in
            
            errorMessage(result.debugDescription) 
            
        }){
            
        }else{
            
            errorMessage("Problamas con el Servicio")
        }
        
    }
}
