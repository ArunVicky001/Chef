//
//  FontHelper.swift
//  Chef
//
//  Created by Vignesh Arunagiri on 06/06/22.
//

import Foundation
import UIKit

struct FontHelper {
    static func defaultBoldFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size)!
    }
    
    static func defaultRegularFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size)!
    }
    
    static func defaultLightFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Light", size: size)!
    }
    
    static func defaultSemiBoldFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Semibold", size: size)!
    }
    
}

