//
//  Target.swift
//  LNTools_fyh_Example
//
//  Created by 付耀辉 on 2020/3/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

open class LN_Target: NSObject {

    
    public var selector : Selector!
    public weak var target : NSObject!
    
    public init(target:NSObject, selector:Selector) {
        super.init()
        
        self.target = target
        self.selector = selector
    }
    
    @discardableResult
    func doAction()  -> Unmanaged<AnyObject>! {
        return self.target.perform(self.selector)
    }
    
    @discardableResult
    func doAction(with object:Any)  -> Unmanaged<AnyObject>! {
        return self.target.perform(self.selector, with: object)
    }
    
    @discardableResult
    func doAction(with object:Any, object2:Any)  -> Unmanaged<AnyObject>! {
        return self.target.perform(self.selector, with: object, with: object2)
    }

    
}
