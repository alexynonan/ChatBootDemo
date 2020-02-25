//
//  ChatBootTableViewCell.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 2/12/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit

class ChatBootTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblMaria : UITextView!
    @IBOutlet weak var lblSender : UILabel!
    
    var objBoot : CMPSBotBE!{
        didSet{
            
            self.lblMaria.isEditable = false
            self.lblMaria.isSelectable = true
            self.lblMaria.dataDetectorTypes = .all
            self.lblMaria.dataDetectorTypes = .link
            self.lblMaria.dataDetectorTypes = .all
            self.lblMaria.text! = self.objBoot.respuesta.replacingOccurrences(of: "\\n", with: "\n")
            self.lblSender.text! = self.objBoot.sender
            
        }
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

