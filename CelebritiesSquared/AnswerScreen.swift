//
//  AnswerScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 9/24/16.
//  Copyright © 2016 Nick Hoyt. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class AnswerScreen: UIViewController {
    
   // @IBOutlet var videoView: UIWebView!
    
    @IBOutlet var videoView: UIWebView!
    
    var timer = Timer()
    var count = 10.000
    var email = ""
    var allowed = false
    var contestName = ""
    var totalScore = Double()
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    var videoCount = 0
    var userAnswer = ""
    var passedName = "ERROR"
    var correctAnswerSegue = "A"
    var player:AVPlayer?
    var tokenNum = ""
    var contestType = ""
    var contestid = ""
    var videoIDArray = [String]()
    var videoURLArray = [String]()
    var questionArray = [String]()
    var answerArray = [NSArray]()
    var responseString = ""
    var userName = ""
    
    var startTime : Double = 0
    
    @IBOutlet var answerOne: UILabel!
    @IBOutlet var answerTwo: UILabel!
    @IBOutlet var answerThree: UILabel!
    @IBOutlet var answerFour: UILabel!
    
    
    @IBOutlet var buttonC: UIButton!
    @IBOutlet var buttonD: UIButton!
    
    
    var tenQuestions:[String] = ["Question: What is your dream job?", "Question: Which girlfriend is Justin Timberlake kissing?", "Question: What Skill or Talent would you like to learn?","True/False: Ryan Reynolds has Four Sisters?","True/False: Is it true you would seriously run for President of the United States of America?","Question: Can you name who this girl is?","True/False: President Obama called Peyton Manning after he lost the 2009 Super Bowl giving him his condolences on the loss?","Question: Who is this woman?","Question: What is the longest you have gone professionally with out an injury?","Question: When you are home what is a typical chilling day?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(videoCount)
        //StartTime
        startTime = NSDate.timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(AnswerScreen.update), userInfo: nil, repeats: true)
        player?.replaceCurrentItem(with: nil)
        player?.pause()
        player = nil
        nameLabel.text = "\(videoCount+1): \(questionArray[videoCount]) "
        if(videoCount == 4){
            
        }
        
        videoAnswerSwitch(videoCount)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func videoAnswerSwitch(_ counte: Int){
        
        //print("answer array \(self.answerArray)")
        print("totalScore \(totalScore)")
        if let ans = answerArray[counte] as? [[String:Any]], !ans.isEmpty {
            
            //print((ans[0]["correctanswer"])!)
            correctAnswerSegue = ((ans[0]["correctanswer"])! as? String)!
           // print("correctanswersegyue \(correctAnswerSegue)")
           // print("count \(ans[0].count)")
            if ans[0].count > 3{
                answerOne.text = (ans[0]["answer1"])! as? String
                answerTwo.text = (ans[0]["answer2"])! as? String
                answerThree.text = (ans[0]["answer3"])! as? String
                answerFour.text = (ans[0]["answer4"])! as? String
            }
            else {
                answerOne.text = (ans[0]["answer1"])! as? String
                answerTwo.text = (ans[0]["answer2"])! as? String
                answerThree.text = ""
                answerFour.text = ""
                buttonC.isHidden = true
                buttonD.isHidden = true
            }
        }
      //  print(self.answerArray[counte].value(forKey: "correctanswer") as? String)
        
       // correctAnswerSegue = (self.answerArray[counte].value(forKey: "correctanswer") as? String)!
        
       //     if let dict = answerArray[counte] as NSDictionary {
      //          print("Here shound be answer 1 \(dict["answer1"])")
     //       }
        
        
               /*
        switch(count){
        case 0:
            print(self.answerArray[0].value(forKey: "answer1"))
            correctAnswerSegue = "A"
            answerOne.text = "Forensic Investigator"
            answerTwo.text = "Professional Singer"
            answerThree.text = "Pediatric Doctor"
            answerFour.text = "Professional Racecar Driver"
            break
        case 1:
            correctAnswerSegue = "C"
            answerOne.text = "Olivia Wild"
            answerTwo.text = "Lindsay Lohan"
            answerThree.text = "Jessica Biel"
            answerFour.text = "Scarlett Johansson"
            break
        case 2:
            correctAnswerSegue = "C"
            answerOne.text = "To Swim"
            answerTwo.text = "To Play Guitar"
            answerThree.text = "To Whistle"
            answerFour.text = "To Fly A Plane"
            break
        case 3:
            correctAnswerSegue = "B"
            answerOne.text = "TRUE"
            answerTwo.text = "FALSE"
            answerThree.text = ""
            answerFour.text = ""
            buttonC.isHidden = true
            buttonD.isHidden = true
            break
        case 4:
            correctAnswerSegue = "A"
            answerOne.text = "TRUE"
            answerTwo.text = "FALSE"
            answerThree.text = ""
            answerFour.text = ""
            buttonC.isHidden = true
            buttonD.isHidden = true
            break
        case 5:
            correctAnswerSegue = "D"
            answerOne.text = "Kourtney Kardashian"
            answerTwo.text = "Mila Kunis"
            answerThree.text = "Katie Holmes"
            answerFour.text = "Huda Beauty Kattan"
            
            break
        case 6:
            correctAnswerSegue = "A"
            answerOne.text = "TRUE"
            answerTwo.text = "FALSE"
            answerThree.text = ""
            answerFour.text = ""
            buttonC.isHidden = true
            buttonD.isHidden = true
            break
        case 7:
            correctAnswerSegue = "C"
            answerOne.text = "Maggie Q - Actress in Nikita"
            answerTwo.text = "Tao Okamoto - Actress in The Wolverine"
            answerThree.text = "Joy Cho - Pinterest Influencer"
            answerFour.text = "Lisa Ling - The View Talk Show Host"
            break
        case 8:
            correctAnswerSegue = "C"
            answerOne.text = "6 Months"
            answerTwo.text = "2 years"
            answerThree.text = "A little over a year"
            answerFour.text = "Never, he's always had some type of injury"
            break
        case 9:
            correctAnswerSegue = "D"
            answerOne.text = "Sleep"
            answerTwo.text = "Have friends over and barbecue"
            answerThree.text = "Play video games"
            answerFour.text = "Go in the pool or go fishing"
            break
        default:
            break
            
            
        }
 */
    }
    
    func postToServerFunctionScore(score: Double, contestName: String, username: String){
        //Contingency Handling. Error handling etc.
        
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/SetLeaderboard.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        print("username to post \(userName)")
        postString = "username=\(userName)&contestname=\(contestName)&score=\(totalScore)&type=\(contestType)&contestid=\(contestid)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            self.responseString = String(data: data, encoding: .utf8)!
            print("responseString = \(self.responseString)")
            
        }
        
        checkResponseString()
        task.resume()
    }
    
    
    func checkResponseString(){
        print(allowed)
        if(self.responseString == "Success"){
            allowed = true
            print("true///////////////////////////////")
            
        }
        else{
            allowed = false
            print("FALSE//////////////////")
        }
    }

    
    func update() {
        if(count > 0)
        {
           
            timerLabel.text = String(format: "%.03f",count)
            //count = count - 0.002 //0.002
            count = 10 - (Date().timeIntervalSinceReferenceDate - startTime)
        } else {
            timer.invalidate()
            print(videoCount)
            print(videoIDArray.count)
            if videoCount >= videoIDArray.count-1 || videoCount >= 10{
                totalScore = Double(String(format: "%.03f",totalScore))!
                postToServerFunctionScore(score: totalScore, contestName: contestName, username: email)
                performSegue(withIdentifier: "lastQuestion", sender: self)
            }
            performSegue(withIdentifier: "afterAnswer", sender: self)
                
            //           let Second:UIViewController = SecondScreen()
            ////
            //           self.presentViewController(Second, animated: true, completion: nil) // this one line performs segue
        }}
    
    //connect cbutton and dbutton and give them same abilities
    //randomize which one is the right answer button.

    @IBAction func answerA(_ sender: Any) {
        userAnswer = "answer1"
        timer.invalidate()
        if videoCount == videoIDArray.count-1 {
            totalScore = Double(String(format: "%.03f",totalScore))!
          //  postToServerFunctionScore(score: totalScore, contestName: contestName, email: email)
            performSegue(withIdentifier: "lastQuestion", sender: self)
        }
        else {
        self.performSegue(withIdentifier: "nextQuestion", sender: self)
        }
    }
    
    @IBAction func answerB(_ sender: Any) {
        userAnswer = "answer2"
        timer.invalidate()
        if videoCount == videoIDArray.count-1 {
            totalScore = Double(String(format: "%.03f",totalScore))!
           // postToServerFunctionScore(score: totalScore, contestName: contestName, email: email)
            performSegue(withIdentifier: "lastQuestion", sender: self)
        }
        else {
        self.performSegue(withIdentifier: "nextQuestion", sender: self)
        }
    }
    
    @IBAction func answerC(_ sender: Any) {
        userAnswer = "answer3"
        timer.invalidate()
        if videoCount == videoIDArray.count-1 {
            totalScore = Double(String(format: "%.03f",totalScore))!
          //  postToServerFunctionScore(score: totalScore, contestName: contestName, email: email)
            performSegue(withIdentifier: "lastQuestion", sender: self)
        }
        else {
        self.performSegue(withIdentifier: "nextQuestion", sender: self)
        }
    }
    
    @IBAction func answerD(_ sender: Any) {
        userAnswer = "answer4"
        timer.invalidate()
        if videoCount == videoIDArray.count-1 {
            
            totalScore = Double(String(format: "%.03f",totalScore))!
           // postToServerFunctionScore(score: totalScore, contestName: contestName, email: email)
            performSegue(withIdentifier: "lastQuestion", sender: self)
        }
        else {
            self.performSegue(withIdentifier: "nextQuestion", sender: self)
        }
    }
    
    

    
    // ctrl drag each wrong button to next screen and name it wrongAnswer.
    // make an if statement up above to change the buttons depending on which video it is
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "afterAnswer" {
            let DestViewController : ContestOverScreen = segue.destination as! ContestOverScreen
            // doSomething(sender as! UIButton)
            DestViewController.passedName = passedName
           // DestViewController.passedAnswerBool = false
            DestViewController.videoCount = videoCount + 1
            DestViewController.totalScore = totalScore
            DestViewController.contestName = contestName;
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.questionArray = questionArray
            DestViewController.videoURLArray = videoURLArray
            DestViewController.videoIDArray = videoIDArray
            DestViewController.answerArray = answerArray
            DestViewController.contestType = contestType
            DestViewController.contestid = contestid
            DestViewController.userName = userName
        }
        
        if segue.identifier == "nextQuestion" {
             let DestViewController : ContestOverScreen = segue.destination as! ContestOverScreen
            if userAnswer == correctAnswerSegue {
                totalScore += count
            }
            DestViewController.passedName = passedName
            // DestViewController.passedAnswerBool = false
            DestViewController.videoCount = videoCount + 1
            DestViewController.totalScore = totalScore
            DestViewController.contestName = contestName
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.questionArray = questionArray
            DestViewController.videoURLArray = videoURLArray
            DestViewController.videoIDArray = videoIDArray
            DestViewController.answerArray = answerArray
            DestViewController.contestType = contestType
            DestViewController.contestid = contestid
            DestViewController.userName = userName
            //print("---------------69---- \(userName) -----------")
        }
        
        
        else if segue.identifier == "lastQuestion" {
           
            let DestViewController : WinnerScreen = segue.destination as! WinnerScreen
            if userAnswer == correctAnswerSegue {
                totalScore += count
            }
            totalScore = Double(String(format: "%.03f",totalScore))!
            // doSomething(sender as! UIButton)
            DestViewController.totalScore = totalScore
            postToServerFunctionScore(score: totalScore, contestName: contestName, username: userName)
            DestViewController.email = email
            DestViewController.contestName = contestName
            DestViewController.tokenNum = tokenNum
            DestViewController.contestType = contestType
            DestViewController.contestid = contestid
            DestViewController.userName = userName
            //print("-----------696969---- \(userName) -----------")
            
            //videoView.loadHTMLString("", baseURL: nil)
            //self.dismiss(animated: true, completion: nil)
        }
            /*
        else if segue.identifier == correctAnswerSegue {
            let DestViewController : ContestOverScreen = segue.destination as! ContestOverScreen
            // doSomething(sender as! UIButton)
            print("I LOVE MASSIVE COCKS")
            DestViewController.passedName = passedName
            //DestViewController.passedAnswerBool = true
            //totalScore += count
            DestViewController.totalScore = totalScore
            DestViewController.videoCount = videoCount + 1
            DestViewController.contestName = contestName;
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.questionArray = questionArray
            DestViewController.videoURLArray = videoURLArray
            DestViewController.videoIDArray = videoIDArray
            DestViewController.answerArray = answerArray
            DestViewController.contestType = contestType
            DestViewController.contestid = contestid
        }
 */
        
    }
    
//    @IBAction func yesButton(sender: AnyObject) {
//        timerLabel.text = String(format: "%.02f",count)
//        timer.invalidate()
//        //  performSegueWithIdentifier("timeOut", sender: self)
//    }
    
//    @IBAction func noButton(sender: AnyObject) {
//        timer.invalidate()
//        timerLabel.text = "10.00"
//    }

    
   
}
