//
//  TestViewController.swift
//  LNTools_fyh_Example
//
//  Created by 付耀辉 on 2020/3/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    
    var target : LN_Target!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightText
        // Do any additional setup after loading the view.
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        target.doAction(with: "123", object2: self)
                
        self.navigationController?.pushViewController(ViewController(), animated: true)
        
    }
    

}
