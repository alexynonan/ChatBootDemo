//
//  ChatBootTableViewCell.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 2/12/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit

class ChatBootTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblRespuesta : UILabel!
    @IBOutlet weak var lblSender : UILabel!
    @IBOutlet weak var viewBoot : UIView!
    
    var objBoot : BootBE!{
        didSet{
            
            if self.objBoot.id == 0{
                self.viewBoot.backgroundColor = .colorFromHexString("#007AFF", withAlpha: 1)

            }else{
                self.viewBoot.backgroundColor = .white
            }
            
            self.lblRespuesta.text! = self.objBoot.respuesta
            self.lblSender.text! = self.objBoot.sender
        }
    }
    
    func constraint(){
        

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}