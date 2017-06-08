//
//  ThirdScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 8/19/16.
//  Copyright © 2016 Nick Hoyt. All rights reserved.
//

//import Foundation
import UIKit
import AVFoundation
class ThirdScreen: UITableViewController {
    
    @IBOutlet var contestLabel: UILabel!
    var buttonName = ""
    var email = ""
    var tokenNum = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //////Background music /////////////////
      //  MusicHelper.sharedHelper.playBackgroundMusic()
        
       
        /////////////////////////////////////////

        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        print(email)
        let year =  components.year!
        let month = components.month!
        let day = components.day!
        contestLabel.text = "Celebrities Squared\n" + String(describing: month) + "/" + String(describing: day) + "/" + String(describing: year)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func nordstromButton(sender: AnyObject) {
//        performSegueWithIdentifier("timeOut", sender: self)
//    }
    
    @IBAction func doSomething(_ sender: UIButton) {
        let propertyToCheck = sender.tag
        switch propertyToCheck {
        case 1:
            buttonName = "Nordstroms"
        case 2:
            buttonName = "Michael Kors"
        case 3:
            buttonName = "Madonna"
        case 4:
            buttonName = "Yankees"
        case 5:
            buttonName = "Ruths Chris"
        case 6:
            buttonName = "Amazon Fire Tablet"
        case 7:
            buttonName = "Channing"
        case 8:
            buttonName = "KimKardashian"
        case 9:
            buttonName = "Bon Jovi"
        case 10:
            buttonName = "Blake Shelton"
        case 11:
            buttonName = "Gucci Hand Bag"
        case 12:
            buttonName = "Macy\'s Gift Card"
        case 13:
            buttonName = "Range Rover Sport"
        case 14:
            buttonName = "Samsung TV 4639.00"
        case 15:
            buttonName = "Meet a Celeb"
        case 16:
            buttonName = "Bellagio " 
        case 17:
            buttonName = "Rhianna"
        case 18:
            buttonName = "IKEA"
        case 19:
            buttonName = "Starbucks"
        case 20:
            buttonName = "lexus"
        case 21:
            buttonName = "AMC"
        case 22:
            buttonName = "Louis Vuitton"
        default: break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MusicHelper.sharedHelper.stopBackgroundMusic()
        if segue.identifier == "backMain" {
            var DestViewController : SecondScreen = segue.destination as! SecondScreen
           // doSomething(sender as! UIButton)
           // DestViewController.passedName = buttonName
           DestViewController.email = email
            DestViewController.tokenNum = tokenNum
          //  DestViewController.userName = userName
        }
        else{
        let DestViewController : TrialGameScreen = segue.destination as! TrialGameScreen
        doSomething(sender as! UIButton)
        DestViewController.passedName = buttonName
        DestViewController.email = email
            DestViewController.tokenNum = tokenNum
          //  DestViewController.userName = userName
        }
        //performSegueWithIdentifier("threeToGame", sender: self)
        
    }
    
}

