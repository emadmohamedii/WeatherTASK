//
//  Fonts.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//


import UIKit

enum FontSize: CGFloat {
    case sixteen = 16
    case small = 15.0
    case medium = 17.0
    case large = 19.0
}

struct Fonts {
    
    struct SFPro {
        
        static func regular(of size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-Regular", size: size)!
        }
                
        static func ultraLight(of size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-UltralightItalic", size: size)!
        }
                
        static func thinItalic(of size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-ThinItalic", size: size)!
        }
                
        static func lightItalic(of size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-LightItalic", size: size)!
        }
        
        static func medium(of size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-Medium", size: size)!
        }
                
        static func bold(of size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-Bold", size: size)!
        }
                
        static func condensedBold(of size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-SemiboldItalic", size: size)!
        }
        
        static func condensedBlack(of size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-BlackItalic", size: size)!
        }
    }
    
}
