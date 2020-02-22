//
//  ChatBootTableViewCell.swift
//  MessagePrueba
//
//  Created by Alexander Johel Ynoñan H on 2/12/20.
//  Copyright © 2020 Alexander Johel Ynoñan H. All rights reserved.
//

import UIKit
import ActiveLabel

class ChatBootTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblRespuesta : ActiveLabel!
    @IBOutlet weak var lblSender : UILabel!
    
    var objBoot : BootBE!{
        didSet{
            
            self.lblRespuesta.customize { (labelUrl) in
              
                labelUrl.text = self.objBoot.respuesta
                let devolucion = labelUrl.text?.replacingOccurrences(of: "\\n", with: "\n")
//                labelUrl.text  = "mailto:frank@wwdcdemo.example.com"
                
                if #available(iOS 13.0, *) {
                    labelUrl.URLColor = .link
                } else {
                    // Fallback on earlier versions
                }
                labelUrl.URLSelectedColor = .blue
                
                labelUrl.handleURLTap { (url) in
                    url.absoluteString.openScheme()
                }
                
                
            
            }
            
            
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
extension String {
    func isValidEmail() -> Bool {
        guard !self.lowercased().hasPrefix("mailto:") else { return false }
        guard let emailDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }
        let matches = emailDetector.matches(in: self, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: self.count))
        guard matches.count == 1 else { return false }
        return matches[0].url?.absoluteString == "mailto:\(self)"
    }
}
