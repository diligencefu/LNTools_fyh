//
//  Toast.swift
//  LNTools_fyh
//
//  Created by MAC on 2020/10/11.
//

import UIKit

@objc public extension UIView {

    //MARK: 设置一个提醒
    @objc enum WWZLToastPosition:Int{
        case top
        case center
        case bottom
    }
    
    func ln_showToast(str:String,position:WWZLToastPosition = WWZLToastPosition.center,isUserInterfaceEnableWhenShow:Bool = true) {
    }
}

public extension DispatchQueue {
    static func ln_runInMain(_ block: @escaping () -> Void) -> Void {
        if Thread.current == Thread.main {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
