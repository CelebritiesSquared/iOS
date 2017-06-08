//
//  ComingScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 2/22/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//

import UIKit
/////heh cumming
class ComingScreen: UIViewController {
    
    var email = ""
    var tokenNum = ""
    var userName = ""
    override func viewDidLoad() {
        print(email)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backtosecond" {
            let DestViewController : SecondScreen = segue.destination as! SecondScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
            
        }
    }
    
}
