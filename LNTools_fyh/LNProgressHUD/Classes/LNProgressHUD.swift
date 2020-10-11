//
//  LNProgressHUD.swift
//  Kingfisher
//
//  Created by 付耀辉 on 2020/4/2.
//

import UIKit
import MBProgressHUD

extension UIImage {
    
    fileprivate class func ly_inSelfBundleNamed(_ name: String) -> UIImage? {

        if let path = Bundle.main.path(forResource: "LNTools_fyh", ofType: "bundle") {
            return UIImage(named: name, in: Bundle(path: path), compatibleWith: nil)
        } else if let path = Bundle.main.path(forResource: "Frameworks/LNTools_fyh.framework/LNTools_fyh", ofType: "bundle") {
            return UIImage(named: name, in: Bundle(path: path), compatibleWith: nil)
        } else {
            return UIImage(named: name)
        }
    }
    
    func imageWithTintColor(tintColor:UIColor) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        tintColor.setFill()
        
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        
        self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }
}


open class LYProgressHUD: MBProgressHUD {
    
    //HUD的背景颜色
    public static var backgroudColor:UIColor = .darkText
    //HUD的内容颜色
    public static var textColor:UIColor = .white
    ///当HUD出现时，当前控制器是否停止继续响应
    public static var isStopUserInteractionEnabledWhenAppear:Bool = true
    
    open func show(animated: Bool, autoHideDelay: TimeInterval) {
        show(animated: animated)
        self.isUserInteractionEnabled = LYProgressHUD.isStopUserInteractionEnabledWhenAppear
        backgroundColor = .clear
        bezelView.backgroundColor = LYProgressHUD.backgroudColor
        contentColor = LYProgressHUD.textColor
        removeFromSuperViewOnHide = true
        label.numberOfLines = 0
        
        if autoHideDelay > 0 {
            hide(animated: animated, afterDelay: autoHideDelay)
        }
    }
    
    open func loadingHud(text: String?) -> Void {
        mode = .indeterminate
        customView = nil
        label.text = text
        
    }
    
    open func textHud(text: String?) -> Void {
        
        mode = .text
        customView = nil
        label.text = text
        
    }
    
    open func successHud(text: String?) -> Void {

        mode = .customView
        customView = nil
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 37, height: 37))
        let image = UIImage.ly_inSelfBundleNamed("hud_success_bgi")?.imageWithTintColor(tintColor: LYProgressHUD.textColor)
        iv.image = image
        customView = iv
        label.text = text
    }
    
    open func failureHud(text: String?) -> Void {

        mode = .customView
        customView = nil
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 37, height: 37))
        let image = UIImage.ly_inSelfBundleNamed("hud_failure_bgi")?.imageWithTintColor(tintColor: LYProgressHUD.textColor)
        iv.image = image
        customView = iv
    }
    
    ///style:   1-横着的条形进度条。2-圆环形进度圈，进度在里圈。3-菊花转。其他：圆形进度条，已进行的部分是实体色，未进行的事浅色
    open func progressHud(proress:CGFloat,text:String?,style:Int=1) {
        
        switch style {
        case 1:
            mode = .determinateHorizontalBar
        case 2:
            mode = .determinate
        case 3:
            mode = .indeterminate
        default:
            mode = .annularDeterminate
        }
        
        label.text = text
        progress = Float(proress)
        
    }
    
    
}


extension DispatchQueue {
    
    fileprivate static func ly_mbph_runInMain(_ block: @escaping () -> Void) -> Void {
        if Thread.current == Thread.main {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}


public extension UIViewController {
    
    var lyHud: LYProgressHUD {
        get {
            let pointer = UnsafeRawPointer(bitPattern: "_buttfly_MBProgressHUD_lyHud".hashValue)!
            let hud = objc_getAssociatedObject(self, pointer) as? LYProgressHUD
            if let hud = hud {
                return hud
            } else {
                let hud = LYProgressHUD(view: view)
                hud.bezelView.style = .solidColor
                objc_setAssociatedObject(self, pointer, hud, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return hud
            }
        }
    }
    
    func ly_showLoadingHUD(text: String?, autoHideDelay: TimeInterval = 1.5) -> Void {
        DispatchQueue.ly_mbph_runInMain {
            self.lyHud.loadingHud(text: text)
            self.view.addSubview(self.lyHud)
            self.lyHud.show(animated: true, autoHideDelay: autoHideDelay)
        }
    }
    
    func ly_showTextHub(text: String?, autoHideDelay: TimeInterval = 1.5) -> Void {
        DispatchQueue.ly_mbph_runInMain {
            self.lyHud.textHud(text: text)
            self.view.addSubview(self.lyHud)
            self.lyHud.progress = 0.5
            self.lyHud.show(animated: true, autoHideDelay: autoHideDelay)
        }
    }
    
    func ly_showSuccessHud(text: String?, autoHideDelay: TimeInterval = 1.5) -> Void {
        DispatchQueue.ly_mbph_runInMain {
            
            self.lyHud.successHud(text: text)
            self.view.addSubview(self.lyHud)
            self.lyHud.isUserInteractionEnabled = false
            self.lyHud.show(animated: true, autoHideDelay: autoHideDelay)
        }
    }
    
    func ly_showFailureHud(text: String?, autoHideDelay: TimeInterval = 1.5) -> Void {
        DispatchQueue.ly_mbph_runInMain {
            self.lyHud.failureHud(text: text)
            self.view.addSubview(self.lyHud)
            self.lyHud.show(animated: true, autoHideDelay: autoHideDelay)
        }
    }
    
    func ly_hideHud(afterDelay delay: TimeInterval = 1.5) -> Void {
        DispatchQueue.ly_mbph_runInMain {
            self.lyHud.hide(animated: true, afterDelay: delay)
        }
    }
    
    func ly_showProgressHud(progress:CGFloat, text:String?, style:Int = 1, autoHideDelay: TimeInterval = 1.5)  {
        
        DispatchQueue.ly_mbph_runInMain {
            self.lyHud.progressHud(proress: progress, text: text, style: style)
            self.view.addSubview(self.lyHud)
            self.lyHud.show(animated: true, autoHideDelay: autoHideDelay)
        }
    }
    
    
}
