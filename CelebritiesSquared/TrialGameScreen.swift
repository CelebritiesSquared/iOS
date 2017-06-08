//
//  TrialGameScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 9/11/16.
//  Copyright © 2016 Nick Hoyt. All rights reserved.
//

import UIKit

class TrialGameScreen: UIViewController {
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var picture: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var csLogo: UIImageView!
    
    var cellTapped = 0
//    var timer = NSTimer()
//    var count = 10.00
    var email = ""
    var totalScore = Double()
    var passedName = "Fundraiser"
    var tokenNum = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        //put switch statement or ifs here to change image and name based on which button was pressed
      //  MusicHelper.sharedHelper.stopBackgroundMusic()
    
               
        picture.image = UIImage(named: passedName)!
        print(cellTapped)
        nameLabel.text = passedName
        
    }
  
//    -(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"nordstrom"]) {
//    picture.image = UIImage(named: "Nordstrom")
//    }
//    
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contestEnter" {
        let DestViewController : ContestOverScreen = segue.destination as! ContestOverScreen
       // doSomething(sender as! UIButton)
        DestViewController.passedName = passedName
        DestViewController.totalScore = totalScore
        DestViewController.email = email
        DestViewController.tokenNum = tokenNum
        }
        if segue.identifier == "backChooser" {
            let DestViewController : SecondScreen = segue.destination as! SecondScreen
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
        }
        //performSegueWithIdentifier("threeToGame", sender: self)
        
    }
    
//    func update() {
//        
//        if(count > 0)
//        {
//            
//            timerLabel.text = String(format: "%.02f",count)
//            count = count - 0.02
//        } else {
//            timer.invalidate()
//            performSegueWithIdentifier("timeOut", sender: self)
//            //           let Second:UIViewController = SecondScreen()
//            ////
//            //           self.presentViewController(Second, animated: true, completion: nil) // this one line performs segue
//        }}

//    @IBAction func yesButton(sender: AnyObject) {
//        timerLabel.text = String(format: "%.02f",count)
//        timer.invalidate()
//        performSegueWithIdentifier("timeOut", sender: self)
//    }
    
//    @IBAction func noButton(sender: AnyObject) {
//        timer.invalidate()
//        timerLabel.text = "10.00"
//    }
    
}
