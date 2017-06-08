//
//  contestOverScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 9/12/16.
//  Copyright © 2016 Nick Hoyt. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ContestOverScreen: UIViewController {
    
  //  @IBOutlet var videoView: UIWebView!
    //var timer = NSTimer()
    var count = 10.00
    var email = ""
    var contestName = ""
    var delayTimes:[Int] = [9, 15, 8, 8, 17, 13, 24, 10, 30, 38]
    var tokenNum = ""
    var videoIDArray = [String]()
    var videoURLArray = [String]()
    var questionArray = [String]()
    var answerArray = [NSArray]()
    var contestType = ""
    var contestid = ""
    var userName = ""
    
    
    @IBOutlet var answerButt: UIButton!
    
    @IBOutlet var lobbyButt: UIButton!
    
    @IBOutlet var skipButton: UIButton!
    
    @IBOutlet var celebCharity: UILabel!

    
    var totalScore = Double()
    //@IBOutlet var nameLabel: UILabel!
    var celebrityCharity:[String] = ["Kim Kardashian playing for XYZ Charity", "Justin Timberlake playing for XYZ Charity", "Rihanna playing for XYZ Charity", "Ryan Reynolds playing for XYZ Charity", "Dwayne Johnson playing for XYZ Charity", "__________ playing for XYZ Charity", "Peyton Manning playing for XYZ Charity", "__________ playing for XYZ Charity", "Travis Pastrana playing for XYZ Charity", "Justin Bieber playing for XYZ Charity",]
    @IBOutlet var videoView: UIView!

    var youtubeUrl = "https://s3-us-west-1.amazonaws.com/celebsquaredvideos/videos/-Kim_Kardashian_West_In_Real_Life_Billboard_Cover_Shoot_Interview.mp4"
    
    
    var tenQuestions:[String] = ["Question: What is your dream job?", "Question: Which girlfriend is Justin Timberlake kissing?", "Question: What Skill or Talent would you like to learn?","True/False: Ryan Reynolds has Four Sisters?","True/False: Is it true you would seriously run for President of the United States of America?","Question: Can you name who this girl is?","True/False: President Obama called Peyton Manning after he lost the 2009 Super Bowl giving him his condolences on the loss?","Question: Who is this woman?","Question: What is the longest you have gone professionally with out an injury?","Question: When you are home what is a typical chilling day?"]
    
    var delayTime = 9
    
    var allVideos:[String] = ["https://s3-us-west-1.amazonaws.com/celebsquaredvideos/videos/-Kim_Kardashian_West_In_Real_Life_Billboard_Cover_Shoot_Interview.mp4",
                              "https://s3-us-west-1.amazonaws.com/celebsquaredvideos/videos/-Justin_Timberlake_and_Jessica_Biel_talking_about_each_other.mp4",
                              "https://s3-us-west-1.amazonaws.com/celebsquaredvideos/videos/-Rihanna_Jim_Parsons_Interview_Each_Other_for_Yahoo.mp4",
                              "https://s3-us-west-1.amazonaws.com/celebsquaredvideos/videos/Sandra_Bullock_and_Ryan_Reynolds_true_or_false_quiz-The_Proposal.mp4",
                              "https://s3-us-west-1.amazonaws.com/celebsquaredvideos/videos/-The_Rock_Talks_Ballers_and_Breakfast.mp4",
                              "https://s3-us-west-1.amazonaws.com/celebsquaredvideos/videos/-Hair_Color_Transformation_with_Huda_Beauty.mp4",
                              "https://s3-us-west-1.amazonaws.com/celebsquaredvideos/videos/-Mike_Klis_interviews_Peyton_Manning_after_White_House_visit.mp4",
                              "https://s3-us-west-1.amazonaws.com/celebsquaredvideos/videos/-Guess_who_this_is.mp4",
                              "https://s3-us-west-1.amazonaws.com/celebsquaredvideos/videos/-Travis_Pastrana_on_the_Fearless_Mindset_with_Lewis_Howes.mp4",
                              "https://s3-us-west-1.amazonaws.com/celebsquaredvideos/videos/-BBC_Radio_1_hangs_out_at_Justin_Biebers_House.mp4"]
    
   
    var videoCount = 0 //-1 //this var will keep track of which video to play next
    
    var passedName = "ERROR"
    var player:AVPlayer = AVPlayer()
    

    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let state : UIApplicationState = UIApplication.shared.applicationState
            
           // MusicHelper.sharedHelper.stopBackgroundMusic()
  
            //print(questionArray)
            NotificationCenter.default.addObserver(self, selector: #selector(self.willActive(_notification:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.willResignActive(_notification:)), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
            
   
            
            answerButt.isHidden = true
            lobbyButt.isHidden = true
            skipButton.isEnabled = false
            skipButton.isHidden = true
            
    /*        if videoCount < 9{
            videoCount += 1
             youtubeUrl = allVideos[videoCount]
                delayTime = delayTimes[videoCount]
            } */
            
                //celebCharity.text = celebrityCharity[videoCount]
           // print(answerArray)
            print("824492987348972394729874897q39")
            print(questionArray)
            print(videoCount)
            
            
            
            
            
            
            if questionArray.count > 0 {
                celebCharity.text = "\(videoCount+1): \(questionArray[videoCount]) "
                self.playVideo(index: videoCount)
            }
            else {
                print("ERROR")
            }
  
        }

    @IBAction func skipButtonFunc(_ sender: Any) {
        NotificationCenter.default.removeObserver(self)
        //  self.videoCount = self.videoCount + 1
        self.videoView.layer.sublayers?.removeLast()
        //playVideo(index: self.index)
        self.performSegue(withIdentifier: "answerEnter", sender: self)
    }
    
    func willResignActive(_notification: NSNotification){
        player.pause()
    }
    
    func willActive(_notification: NSNotification){
        player.play()
        print("Here")
    }
    
    func playVideo(index: Int){
        print("videocapacity---------- \(videoURLArray.count)")
    
        if(index <= videoURLArray.count){
            let videoURL = NSURL(string: videoURLArray[index])
            
            player = AVPlayer(url: videoURL! as URL)
            let playerLayer = AVPlayerLayer(player: player)
            //playerLayer.frame = self.view.bounds
            playerLayer.frame = self.videoView.bounds
            self.videoView.layer.addSublayer(playerLayer)
            player.play()
            
            NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            
            
            if player.rate != 0{
                self.skipButton.isEnabled = true
                self.skipButton.isHidden = false
            }
            
        }
    }
    
    func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
       
        NotificationCenter.default.removeObserver(self)
      //  self.videoCount = self.videoCount + 1
        self.videoView.layer.sublayers?.removeLast()
        player.volume = 0
        //playVideo(index: self.index)
         self.performSegue(withIdentifier: "answerEnter", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.pause()
        self.videoView.layer.sublayers?.removeLast()
        player.volume = 0
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "answerEnter" {
            let DestViewController : AnswerScreen = segue.destination as! AnswerScreen
            
            DestViewController.player = player
            DestViewController.passedName = passedName
            DestViewController.totalScore = totalScore
            DestViewController.videoCount = videoCount
            DestViewController.email = email
            DestViewController.contestName = contestName
            DestViewController.tokenNum = tokenNum
            DestViewController.questionArray = questionArray
            DestViewController.videoURLArray = videoURLArray
            DestViewController.videoIDArray = videoIDArray
            DestViewController.answerArray = answerArray
            DestViewController.contestType = contestType
            DestViewController.contestid = contestid
            print("---------------69---- \(email) -----------")
            DestViewController.userName = userName
           
            
            
        }
    }
    
}


    
