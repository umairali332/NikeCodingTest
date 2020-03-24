//
//  UIFont+Extension.swift
//  MoviesListing
//
//  Created by Umair Ali on 30/04/2019.
//  Copyright © 2019 Umair Ali. All rights reserved.
//

import UIKit

extension UIFont {
    enum FontSize {
        case standard(StandardSize)
        case custom(CGFloat)
        var value: CGFloat {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }
    
    enum FontName: String {
        case avenirDemiBold = "AvenirNextCondensed-DemiBold"
        case avenirRegular = "AvenirNextCondensed-Regular"
        
    }
    
    enum StandardSize: CGFloat {
        case h1 = 24.0
        case h2 = 22.0
        case h3 = 20.0
        case h4 = 18.0
        case h5 = 16.0
        case h6 = 14.0
    }
    
    convenience init(_ name: FontName, size: FontSize) {
        self.init(name: name.rawValue, size: size.value)!
    }
}
