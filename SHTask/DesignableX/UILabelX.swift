////
////  UILabelX.swift
////  DesignableXTesting
////
////  Created by Mark Moeykens on 1/28/17.
////  Copyright © 2017 Moeykens. All rights reserved.
////
//
//import UIKit
//
//@IBDesignable
//class UILabelX: UILabel {
//    
//    @IBInspectable override var cornerRadius: CGFloat  {
//        didSet {
//            self.layer.cornerRadius = cornerRadius
//        }
//    }
//    
//    @IBInspectable override var borderWidth: CGFloat  {
//        didSet {
//            self.layer.borderWidth = borderWidth
//        }
//    }
//    
//    @IBInspectable override var borderColor: UIColor  {
//        didSet {
//            self.layer.borderColor = borderColor.cgColor
//        }
//    }
//    
//    @IBInspectable var rotationAngle: CGFloat = 0 {
//        didSet {
//            self.transform = CGAffineTransform(rotationAngle: rotationAngle * .pi / 180)
//        }
//    }
//    
//    // MARK: - Shadow Text Properties
//    
//    @IBInspectable public var shadowOpacity: CGFloat = 0 {
//        didSet {
//            layer.shadowOpacity = Float(shadowOpacity)
//        }
//    }
//    
//    @IBInspectable public var shadowColorLayer: UIColor = UIColor.clear {
//        didSet {
//            layer.shadowColor = shadowColorLayer.cgColor
//        }
//    }
//    
//    @IBInspectable public var shadowRadius: CGFloat = 0 {
//        didSet {
//            layer.shadowRadius = shadowRadius
//        }
//    }
//    
//    @IBInspectable public var shadowOffsetLayer: CGSize = CGSize(width: 0, height: 0) {
//        didSet {
//            layer.shadowOffset = shadowOffsetLayer
//        }
//    }
//}
