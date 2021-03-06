//
//  CSMColorManager.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 14/03/18.
//

import UIKit

public extension UIColor {
    
    private class func intFromHexString(_ hexString: String) -> UInt32{
        
        var hexInt : UInt32 = 0
        
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet.init(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        
        return hexInt
    }
    
    class func colorFromHexString(_ hexString: String, withAlpha alpha: CGFloat) -> UIColor {
        
        let hexint = self.intFromHexString(hexString)
        
        let red = CGFloat((hexint & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(hexint & 0xFF) / 255.0
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
}
