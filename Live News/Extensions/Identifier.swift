//
//  BoldedFont.swift
//  Live News
//
//  Created by jaber on 14/02/2022.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    @IBInspectable
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
             layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    public var shadowOffset: CGSize {
        get {
            layer.shadowOffset
        }
        set {
             layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    public var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor)
        }

        set {
            layer.shadowColor = newValue.cgColor
        }
    }
}

extension UIImage {
    static var placeholderImage = UIImage(named: "placeholderImage")
}
