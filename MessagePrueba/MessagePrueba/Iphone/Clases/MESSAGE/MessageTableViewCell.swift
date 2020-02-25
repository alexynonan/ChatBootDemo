//
//  MessageTableViewCell.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 1/21/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPublicacion : UILabel!
    @IBOutlet weak var lblFecha : UILabel!
    
    var objMessage : Message!{
        didSet{
            self.lblPublicacion.text = self.objMessage.publicacion
            self.lblFecha.text = self.objMessage.fecha
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
