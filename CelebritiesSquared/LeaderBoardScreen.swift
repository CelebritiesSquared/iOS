//
//  LeaderBoardScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 10/3/16.
//  Copyright © 2016 Nick Hoyt. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class LeaderBoardScreen: UIViewController {
    
    // @IBOutlet var videoView: UIWebView!
    var totalScore = Double()
    var email = ""
    var orderedArray = [String]()
    var finalDict = [String: Double]()
    @IBOutlet var scoreLabel: UILabel!
    
    
    @IBOutlet var nameLabel2: UILabel!
    
    @IBOutlet var nameLabel3: UILabel!
    
    
    @IBOutlet var nameLabel4: UILabel!
    
    @IBOutlet var nameLabel5: UILabel!
    
    
    @IBOutlet var scoreLabel2: UILabel!
    
    @IBOutlet var scoreLabel3: UILabel!
    
    
    @IBOutlet var scoreLabel4: UILabel!
    
    @IBOutlet var scoreLabel5: UILabel!
    
//    @IBOutlet var scoreColor1: UIImageView!
//    
//    @IBOutlet var scoreColor2: UIImageView!
//    
//    @IBOutlet var scoreColor3: UIImageView!
//    
//    @IBOutlet var scoreColor4: UIImageView!
//    
//    @IBOutlet var scoreColor5: UIImageView!
    
    var leaderDict = [String: Double]()
    @IBOutlet var nameLabel: UILabel!
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
   //  scoreLabel.text = String(format:"%f", totalScore)
  //  nameLabel.text = userName
    
//    userDefaults.setValue(totalScore, forKey: userName)
//    userDefaults.synchronize() // don't forget this!!!!
        for items in UserDefaults.standard.dictionaryRepresentation(){
            if items.1 is Double {
                
               if (items.1 as! Double) > 20.0 && (items.1 as! Double) < 100.0{
                
                   leaderDict[items.0] = (items.1 as! Double)
                
            }
        }
        
        }
        if leaderDict[email] != nil {
            if totalScore > leaderDict[email] {
                leaderDict[email] = totalScore
                userDefaults.setValue(totalScore, forKey: email)
                userDefaults.synchronize() // don't forget this!!!!
            }
            
        }
        else{
            userDefaults.setValue(totalScore, forKey: email)
            userDefaults.synchronize() // don't forget this!!!!
            leaderDict[email] = totalScore
        }
        
        var count = 0
        let sortedKeys = Array(leaderDict.values).sorted(by: >)
        var n = 5
        if sortedKeys.count < 5 {
            n = sortedKeys.count
        }
        var topFive = sortedKeys[0..<n]
        for item in topFive {
            for stuff in leaderDict {
                if item == stuff.1{
                    finalDict[stuff.0] = stuff.1
                    orderedArray.append(stuff.0)
                    print(stuff.0 + String(stuff.1))
                }
            }
        }
        
        var nameArray: Array<UILabel> = [nameLabel, nameLabel2, nameLabel3, nameLabel4, nameLabel5]
        var scoreArray: Array<UILabel> = [scoreLabel, scoreLabel2, scoreLabel3, scoreLabel4, scoreLabel5]
        
        for (first, second) in orderedArray.enumerated(){
            print("HERE")
            print(first)
            nameArray[first].text = String(first + 1) + ") " + orderedArray[first]
            scoreArray[first].text = String((Double(round(1000*finalDict[orderedArray[first]]!)/1000)))

                   }
        //Double(round(1000*x)/1000)
//        nameLabel.text = orderedArray[0]
//        scoreLabel.text = String(finalDict[orderedArray[0]]!)
//        //print(finalDict[orderedArray[0]]!)
//
//        nameLabel2.text = orderedArray[1]
//        scoreLabel2.text = String(finalDict[orderedArray[1]]!)
//        nameLabel3.text = orderedArray[2]
//        scoreLabel3.text = String(finalDict[orderedArray[2]]!)
//        nameLabel4.text = orderedArray[3]
//        scoreLabel4.text = String(finalDict[orderedArray[3]]!)
//        nameLabel5.text = orderedArray[4]
//        scoreLabel5.text = String(finalDict[orderedArray[4]]!)
    }
    
    
    @IBAction func clearButton(_ sender: AnyObject) {
        for items in leaderDict{
            userDefaults.removeObject(forKey: items.0)
        }
        nameLabel.text = ""
        nameLabel2.text = ""
        nameLabel3.text = ""
        nameLabel4.text = ""
        nameLabel5.text = ""
        scoreLabel.text = ""
        scoreLabel2.text = ""
        scoreLabel3.text = ""
        scoreLabel4.text = ""
        scoreLabel5.text = ""
        
        
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    
    
}
