//
//  CMPSChatBotWS.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 2/21/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit
import ApiAI

public typealias Completion = (_ resultado : String) -> Void
public typealias ErrorMessage = (_ errorMessage : String) -> Void

class CMPSChatBotWS: NSObject {

    class func getChatString(_ pregunta : String, _ errorMessage : @escaping ErrorMessage){
        
        let refApiAi = ApiAI.shared()?.textRequest()
        
        refApiAi?.query = pregunta
        CMPSFirebaseBC.getQuestionUser(pregunta, errorMessage)
        
        refApiAi?.setMappedCompletionBlockSuccess({ (request, result) in
            
            let requestText = result as? AIResponse
            
            if let textResponse = requestText?.result.fulfillment.speech {
                CMPSFirebaseBC.getQuestionBot(textResponse, errorMessage)
            }else{
                errorMessage("Problemas con el Servicio")
            }
            
        }, failure: { (request, result) in
            
            errorMessage(result.debugDescription) 
            
        })
        
        ApiAI.shared().enqueue(refApiAi)
    }
}
