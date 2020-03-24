//
//  UIColor+Extension.swift
//  MoviesListing
//
//  Created by Umair Ali on 30/04/2019.
//  Copyright © 2019 Umair Ali. All rights reserved.
//

import UIKit

extension UIColor {
    enum ColorHexType {
        case standard(StandardColorHex)
        case custom(UInt32)
        
        var hex: UInt32 {
            switch self {
            case .standard(let standard): return standard.rawValue
            case .custom(let hex): return hex
            }
        }
        
    }
    
    enum StandardColorHex: UInt32 {
        case themeColor = 0x333337
    }
    
    private convenience init(hex: UInt32) {
        let mask = 0x000000FF
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    convenience init(color: ColorHexType) {
        self.init(hex: color.hex)
    }
}
