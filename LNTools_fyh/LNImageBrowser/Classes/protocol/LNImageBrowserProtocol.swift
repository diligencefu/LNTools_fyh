//
//  LNImageBrowserProtocol.swift
//  Basic
//
//  Created by 付耀辉 on 2020/3/21.
//  Copyright © 2020 赤岚欣. All rights reserved.
//

import UIKit

open class LNImageBrowser : NSObject {
    
    public var subImageViews : [UIImageView] = [UIImageView]()
    
    public func addImageBrowser<T:LNImageBrowserProtocol>(obj:T) {
        
        self.subImageViews.removeAll()
        for index in 0..<obj.ln_imageViews.subviews.count {
            if let imageView = obj.ln_imageViews.subviews[index] as? UIImageView {
                
                imageView.isUserInteractionEnabled = true
                let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(viewTheBigImage(ges:)))
                singleTap.numberOfTapsRequired = 1
                singleTap.numberOfTouchesRequired = 1
                imageView.addGestureRecognizer(singleTap)
                imageView.currentTag = 100+index
                self.subImageViews.append(imageView)
            }
        }
    }
    
    
    @objc public func viewTheBigImage(ges:UITapGestureRecognizer) {
        
        guard let superView = ges.view?.viewContainingProtocol() else {
            return
        }
        
        var images = [KSPhotoItem]()
        for index in 0 ..< self.subImageViews.count {
            let imageView = self.subImageViews[index]
            let watchIMGItem = KSPhotoItem.init(sourceView: imageView, image: imageView.image)
            images.append(watchIMGItem!)
        }
        
        var selectIndex = 0
        for imageView in self.subImageViews {
            if imageView == ges.view {
                selectIndex = (imageView.currentTag ?? 100) - 100
                break
            }
        }
        
        let watchIMGView = KSPhotoBrowser.init(photoItems: images,
                                               selectedIndex:UInt(selectIndex))
        watchIMGView?.dismissalStyle = .scale
        watchIMGView?.backgroundStyle = .blurPhoto
        watchIMGView?.loadingStyle = .indeterminate
        watchIMGView?.pageindicatorStyle = .text
        watchIMGView?.bounces = false
        watchIMGView?.isDefult = superView.ln_browserLongpressStyle() == .defult
        watchIMGView?.didLongpressedImageCallback({ (image, index) in
            guard let browser = watchIMGView, let image = image else {
                return
            }
            superView.ln_browser(browser: browser, didLongpressedAt: index, with: image)
        })
        watchIMGView?.show(from: ges.view?.viewContainingController1())
    }
}



@objc public enum LNLongpressMode : Int {
    case defult = 0
    case coustom
}

public protocol LNImageBrowserProtocol : NSObject {
    
    var ln_imageViews : UIView {get set}
    
    func ln_browserLongpressStyle() -> LNLongpressMode
    
    func ln_browser(browser:UIViewController, didLongpressedAt index:NSInteger, with image:UIImage)
}

public extension LNImageBrowserProtocol {
    
    func ln_browserLongpressStyle() -> LNLongpressMode {
        return .defult
    }
    
    func ln_browser(browser:UIViewController, didLongpressedAt index:NSInteger, with image:UIImage) {
        
    }
}


fileprivate extension UIView {
    
    @objc func viewContainingController1()->UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
    
    
    func viewContainingProtocol()->LNImageBrowserProtocol? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? LNImageBrowserProtocol {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
    
    
    var currentTag: Int? {
        get {
            
            guard let pointer = UnsafeRawPointer(bitPattern: "_ln_view_image_current_index_".hashValue)  else {
                return nil
            }
            return (objc_getAssociatedObject(self, pointer) as? Int)
        }
        
        set(newValue) {
            
            guard let pointer = UnsafeRawPointer(bitPattern: "_ln_view_image_current_index_".hashValue)  else {
                return
            }
            objc_setAssociatedObject(self, pointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


