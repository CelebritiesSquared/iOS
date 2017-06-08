//
//  ProgressScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 2/22/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//

import UIKit

class ProgressScreen: UIViewController {

    var email = ""
    var contestName = ""
    var contestType = ""
    var tokenNum = ""
    var contestid = ""
    var userName = ""
    var cost = ""
    var fundraiserImage = ""
    var imgURLArray = [String]()
    var prize = ""
    var videoIDArray = [String]()
    var videoURLArray = [String]()
    var questionArray = [String]()
    var currentArray = [String]()
    var answerArray = [NSArray]()
    var imageURL: NSURL!
    
    @IBOutlet var progressImage: UIImageView!
    
    @IBOutlet var currentAmountLabel: UILabel!
    override func viewDidLoad() {
        //print(email)
        print(contestName)
        print(contestType)
        if contestType == "fundraiser"{
            imageURL = NSURL(string: self.fundraiserImage)!
            if imageURL != nil{
                let data = NSData(contentsOf: (imageURL as? URL)!)
                self.progressImage.image = UIImage(data: data as! Data)
        }
        }
            else{
        if self.imgURLArray.count != 0{
            imageURL = NSURL(string: self.imgURLArray[0])!
            if imageURL != nil{
                let data = NSData(contentsOf: (imageURL as? URL)!)
                self.progressImage.image = UIImage(data: data as! Data)
            }
        }
            }
        
        currentAmountLabel.text = "Total Amount Earned So Far:\n$\(currentArray[0])"

    }
    
    
    @IBAction func backButt(_ sender: Any) {
        self.performSegue(withIdentifier: "backtocontest", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backtosecond" {
            let DestViewController : SecondScreen = segue.destination as! SecondScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
            
        }
        if segue.identifier == "backtocontest" {
            let DestViewController : ContestScreen = segue.destination as! ContestScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.contestName = contestName
            DestViewController.tokenNum = tokenNum
            DestViewController.videoURLArray = videoURLArray
            DestViewController.videoIDArray = videoIDArray
            DestViewController.answerArray = answerArray
            DestViewController.questionArray = questionArray
            DestViewController.contestType = contestType
            DestViewController.contestid = contestid
            DestViewController.userName = userName
            DestViewController.cost = cost
            DestViewController.imgURLArray = imgURLArray
            DestViewController.prize = prize
            DestViewController.currentArray = currentArray
            DestViewController.fundraiserImage = fundraiserImage
           
            
            
        }
    }

}
