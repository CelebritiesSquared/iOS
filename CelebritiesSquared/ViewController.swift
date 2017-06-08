//
//  ViewController.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 8/19/16.
//  Copyright © 2016 Nick Hoyt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userName = ""
    @IBOutlet var kimImage: UIImageView!
    @IBOutlet var background: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    @IBAction func startButt(sender: AnyObject) {
//        var alertController:UIAlertController?
//        alertController = UIAlertController(title: "Enter Text",
//            message: "Enter some text below",
//            preferredStyle: .Alert)
//        
//        alertController!.addTextFieldWithConfigurationHandler(
//            {(textField: UITextField!) in
//                textField.placeholder = "Enter something"
//        })
//        
//        let action = UIAlertAction(title: "Submit",
//            style: UIAlertActionStyle.Default,
//            handler: {[weak self]
//                (paramAction:UIAlertAction!) in
//                if let textFields = alertController?.textFields{
//                    let theTextFields = textFields as [UITextField]
//                    let enteredText = theTextFields[0].text
//                    self!.userName = enteredText!
//                }
//            })
//        
//        alertController?.addAction(action)
//        self.presentViewController(alertController!,
//            animated: true,
//            completion: nil)
//    }

}

