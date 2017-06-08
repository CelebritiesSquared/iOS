//
//  AfterAnswer.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 9/26/16.
//  Copyright © 2016 Nick Hoyt. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class AfterAnswer: UIViewController {
    
    // @IBOutlet var videoView: UIWebView!
    
    
   // @IBOutlet var videoView: UIWebView!
    
  //  var timer = NSTimer()
  //  var count = 10.00
     var timer = Timer()
    var count = 1
    var contestName = ""
    var tokenNum = ""
    var contestType = ""
    var contestid = ""
    @IBOutlet var timeLabel: UILabel!
    var responseString = ""
    var videoIDArray = [String]()
    var videoURLArray = [String]()
    var questionArray = [String]()
    var answerArray = [NSArray]()
 //   @IBOutlet var timerLabel: UILabel!
    var email = ""
  //  @IBOutlet var scoreLabel: UILabel!
    var allowed = false
    var totalScore = Double()
 //   @IBOutlet var nameLabel: UILabel!
    var passedName = "ERROR"
    var passedAnswerBool = false
    var videoCount = 0 
    var youtubeUrl = "https://www.youtube.com/embed/hKkklMJ_4I4"
   // https://www.youtube.com/embed/3NvcjdK32Lg?rel=0&amp;controls=0&amp;showinfo=0?&start=129&end=133
    var allVideos:[String] = ["https://www.youtube.com/embed/QO-Iu9ANsTI?rel=0&amp;controls=0&amp;showinfo=0?&start=39&end=43", "https://www.youtube.com/embed/EPX8lOveo34?rel=0&amp;controls=0&amp;showinfo=0?&start=365&end=405",
        "https://www.youtube.com/embed/GNyxtJQr26I?rel=0&amp;controls=0&amp;showinfo=0?&start=132&end=162",
        "https://www.youtube.com/embed/3NvcjdK32Lg?rel=0&amp;controls=0&amp;showinfo=0?&start=133&end=159", //4
        "https://www.youtube.com/embed/zIrLJ0cuE2Q?rel=0&amp;controls=0&amp;showinfo=0?&start=109&end=136", //5
        "https://www.youtube.com/embed/jG-1WXVUWBc?rel=0&amp;controls=0&amp;showinfo=0?&start=7&end=16",    //6
        "https://www.youtube.com/embed/E5bds9Ziu9c?rel=0&amp;controls=0&amp;showinfo=0?&start=55&end=96",   //7
        "https://www.youtube.com/embed/HS2hU_1p9K0?rel=0&amp;controls=0&amp;showinfo=0?&start=0&end=3",     //8
        "https://www.youtube.com/embed/IA8cyo5QpdU?rel=0&amp;controls=0&amp;showinfo=0?&start=26&end=47",    //9
        "https://www.youtube.com/embed/8Xg7qr-bb9w?rel=0&amp;controls=0&amp;showinfo=0?&start=33&end=44"]    //10
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(AfterAnswer.update), userInfo: nil, repeats: true)
        
        if videoCount < 10{
           // videoCount++
            youtubeUrl = allVideos[videoCount]
        }
        

    }
    
    ///////////////////UPLOAD TOTALSCORE TO DB/////////////////////
    
    func postToServerFunctionScore(score: Double, contestName: String, email: String){
        //Contingency Handling. Error handling etc.
       // print(email)
     //   print(contestName)
      //  print(totalScore)
        
        
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/SetLeaderboard.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        postString = "email=\(email)&contestname=\(contestName)&score=\(totalScore)&id=\(contestid)"
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
    

    
   
    
    ////////////////////END UPLOAD TO DB///////////////////////////
    
    func update() {
        
        if(count > 0)
        {
            
            timeLabel.text = String(count)
            count = count - 1
        } else {
            timer.invalidate()
            if(videoCount == 9){
                totalScore = Double(String(format: "%.03f",totalScore))!
                print(totalScore)
                postToServerFunctionScore(score: totalScore, contestName: contestName, email: email)
                performSegue(withIdentifier: "lastQuestion", sender: self)

            }
            else{
                performSegue(withIdentifier: "notLast", sender: self)
            }
            //           let Second:UIViewController = SecondScreen()
            ////
            //           self.presentViewController(Second, animated: true, completion: nil) // this one line performs segue
        }}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lastQuestion" {
            let DestViewController : WinnerScreen = segue.destination as! WinnerScreen
            // doSomething(sender as! UIButton)
            DestViewController.totalScore = totalScore
            DestViewController.email = email
            DestViewController.contestName = contestName
            DestViewController.tokenNum = tokenNum
            DestViewController.contestType = contestType
            DestViewController.contestid = contestid
            //videoView.loadHTMLString("", baseURL: nil)
            //self.dismiss(animated: true, completion: nil)
        }
        if segue.identifier == "notLast" {
            let DestViewController : ContestOverScreen = segue.destination as! ContestOverScreen
            DestViewController.videoCount = videoCount
            DestViewController.totalScore = totalScore
            DestViewController.email = email
            DestViewController.contestName = contestName
            DestViewController.tokenNum = tokenNum
            DestViewController.questionArray = questionArray
            DestViewController.videoURLArray = videoURLArray
            DestViewController.videoIDArray = videoIDArray
            DestViewController.answerArray = answerArray
            DestViewController.contestType = contestType
            DestViewController.contestid = contestid
          //  videoView.loadHTMLString("", baseURL: nil)
           // self.dismiss(animated: true, completion: nil)
        }
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
 /*       @IBAction func nextQuestion(_ sender: AnyObject) {
            print(videoCount)
            if videoCount == 9 {
                performSegue(withIdentifier: "lastQuestion", sender: self)
            }
            else{
                performSegue(withIdentifier: "notLast", sender: self)
            }
           // performSegueWithIdentifier("lastQuestion", sender: self)
        }
*/
    
    }
    

