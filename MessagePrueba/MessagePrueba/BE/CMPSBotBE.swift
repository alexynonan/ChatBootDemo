//
//  CMPSBotBE.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 2/25/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit

class CMPSBotBE: NSObject {
    
    var respuesta = ""
    var sender = ""
    var id = 0
    
    class func parse(_ json : [String : Any]) -> CMPSBotBE{
        
        let objBotBE = CMPSBotBE()

        objBotBE.respuesta = json["respuesta"] as? String ?? ""
        objBotBE.sender = json["sender"] as? String ?? ""
        objBotBE.id = json["id"] as? Int ?? 0
        
        return objBotBE
    }
}
