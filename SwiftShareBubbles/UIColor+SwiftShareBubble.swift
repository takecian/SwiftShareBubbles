//
//  UIColor+SwiftShareBubble.swift
//  SwiftShareBubbles
//
//  Created by FUJIKI TAKESHI on 2017/03/12.
//  Copyright © 2017 com.takecian. All rights reserved.
//

import UIKit

extension UIColor {
    class func colorFromRGB(_ rgb: String, alpha: CGFloat = 1) -> UIColor {
        let scanner = Scanner(string: rgb)
        var rgbInt: UInt32 = 0
        scanner.scanHexInt32(&rgbInt)
        
        let r = CGFloat(((rgbInt & 0xFF0000) >> 16)) / 255.0
        let g = CGFloat(((rgbInt & 0x00FF00) >> 8)) / 255.0
        let b = CGFloat(rgbInt & 0x0000FF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}
