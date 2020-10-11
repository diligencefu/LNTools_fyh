//
//  UIViewTools.swift
//  AFNetworking
//
//  Created by 付耀辉 on 2020/3/19.
//

import UIKit

public extension UIView {
    
    var x : CGFloat {
        get {
            frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var y : CGFloat {
        get {
            frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var width:CGFloat{
        get {
            bounds.width
        }
        set {
            self.bounds = CGRect.init(x: 0, y: 0, width: newValue, height: self.bounds.height)
        }

    }
    
    var height:CGFloat{

        get {
            bounds.height
        }
        
        set {
            self.bounds = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: newValue)
        }

    }
    
    var centerY:CGFloat {
        get {
            center.y
        }
        set {
            center.y = newValue
        }
    }
    
    var centerX:CGFloat {
        get {
            center.x
        }
        set {
            center.x = newValue
        }
    }
    
    var right:CGFloat {
        get {
            x+width
        }
        set {
            x = newValue - width
        }
    }
    
    var bottom:CGFloat {
        get {
            y+height
        }
        set {
            y = newValue - height
        }
    }

    @objc func ln_viewContainingController()->UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
        
    }
}

 extension UIViewController {

}

