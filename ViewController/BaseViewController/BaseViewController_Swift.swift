//
//  BaseViewController_Swift.swift
//  RoyMVVM
//
//  Created by RoyGuo on 15/5/15.
//  Copyright (c) 2015年 RoyGuo. All rights reserved.
//

import UIKit

class BaseViewController_Swift: BaseViewController_OC {
    
    var tt:String = "123"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.test();
        self.test2();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
         
    }

    
    func test2(){
        tt="333"
        
        print("tt:\(tt)");
    }
    
    func test3(){
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
