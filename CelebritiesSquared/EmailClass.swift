//
//  EmailClass.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 3/6/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//

import Foundation
import MessageUI
import UIKit

class EmailClass: UIViewController, MFMailComposeViewControllerDelegate {
    
    var email = ""
    var toArray = [String]()
    static let sharedHelper = EmailClass()
    override func viewDidLoad() {
        super.viewDidLoad()
        toArray.append(email)
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        //sendEmail(email: email, password: String)
    }
    
    func sendEmail(email: String, password: String) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        print(toArray)
        composeVC.setToRecipients(toArray)
        composeVC.setSubject("Welcome to Celebrities Squared!")
        composeVC.setMessageBody("Your password is: \(password)", isHTML: false)
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        // Check the result or perform other tasks.
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
