//
//  CSMString.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 2/04/18.
//

import UIKit

extension String{
    
    func base64Decode() -> Data? {
        
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        
        if paddingLength > 0 {
            
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            
            base64 += padding
        }
        
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func mailIsValid() -> Bool {

        let emailRegex = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    func mailIsValid(stricterFilter : Bool) -> Bool {
        
        let stricterFilterString = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        let laxString = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let emailRegex = stricterFilter ? stricterFilterString : laxString;
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    func replacing(range: CountableClosedRange<Int>, with replacementString: String) -> String {
        
        let start = index(replacementString.startIndex, offsetBy: range.lowerBound)
        let end   = index(start, offsetBy: range.count)
        return self.replacingCharacters(in: start ..< end, with: replacementString)
    }
    
    func minCaracteresPassowrd(caracteres : Int) -> Bool{
        
        if self.count < caracteres {
            return false
        }
        
        let soloLetras = self.components(separatedBy: CharacterSet(charactersIn: "1234567890").inverted).joined(separator: "")
        
        if soloLetras.count == self.count{
            return false
        }
        
        return true
    }
    
    func openScheme(){
        
        if let scheme = self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: scheme){
            
            UIApplication.shared.open(url, options: [:], completionHandler: {
                (success) in
                print("Open \(self): \(success)")
            })
            
        }
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
}
