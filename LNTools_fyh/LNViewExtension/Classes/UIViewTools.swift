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

    @objc func viewContainingController()->UIViewController? {
        
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


public extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, alph:CGFloat = 1) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alph)
    }

    convenience init(gary: CGFloat) {
        self.init(red:gary / 255.0, green: gary / 255.0, blue: gary / 255.0, alpha: 1)
    }

    convenience init(hex:String){
        //处理数值
        var cString = hex.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let length = (cString as NSString).length
        //错误处理
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){
            //返回whiteColor
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            return
        }
        
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        
        //字符chuan截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        //存储转换后的数值
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }

}
