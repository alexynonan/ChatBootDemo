//
//  CMPSBootBE.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 2/24/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit

class CMPSBootBE: NSObject {
    
    var respuesta = ""
    var sender = ""
    var id = 0
    
    class func parse(_ json : [String : Any]) -> CMPSBootBE{
        
        let objBootBE = CMPSBootBE()
        
        objBootBE.id = json["id"] as? Int ?? 0
        objBootBE.respuesta = json["respuesta"] as? String ?? "-"
        objBootBE.sender = json["sender"] as? String ?? "-"
        
        return objBootBE
    }
}
