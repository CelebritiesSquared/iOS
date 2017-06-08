//
//  HowToPlayScreen.swift
//  CelebritiesSquared
//
//  Created by Dori Mouawad on 2/18/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//

import UIKit
import ImageSlideshow

class HowToPlayScreen: UIViewController {
    
    //Passed in information
    var email = ""
    var tokenNum = ""
    
    //Label and Button declaration
    @IBOutlet var htpLabel: UILabel!
    @IBOutlet var mainlobbyButton: UIButton!
    
    //NEW CHANGES BEGIN
    //Open in portrait mode
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    //Slideshow declaration
    @IBOutlet var slideshow : ImageSlideshow!
    
    @IBOutlet var instText: UITextView!
    //Image Declaration
    
    let localSource = [ImageSource(imageString: "HowToPlayMainLobby")!,
                       ImageSource(imageString: "HowToPlayArrowProfile")!,
                       ImageSource(imageString: "HowToPlayArrowScore")!,
                       ImageSource(imageString: "HowToPlayArrowPassword")!,
                       ImageSource(imageString: "HowToPlayArrowContest")!,
                       ImageSource(imageString: "HowToPlayArrowDetails")!,
                       ImageSource(imageString: "HowToPlayPlayNow")!,
                       ImageSource(imageString: "Title Screen")!]
    
    
    var instructions: [String] = ["Click on the Main Lobby Button.", "Click this button to view your profile.", "In the profile section, you can click on your scores for active contests to view the leaderboard. You can also link with your Facebook account if you have not done so.", "Additionally, you can change your password, and purchase tokens (securely by setting up a credit card for all tokens purchased) here. Your credit card will be saved in your user profile.", "We offer two different types of contests: VIP and Free Daily.", "Click a contest type to go to that Contest Lobby, where you can view a celebrities profile or view the details of the desired contest", "Finally, you can play a contest by clicking the 'Play Now' button, which will lead you into the game in which you must answer a series of  multiple choice or true/false trivia within 10 seconds!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Alert:UIAlertView = UIAlertView(title: "How To Play", message: "Please SWIPE through these instructions to learn the basics of Celebrities Squared", delegate: self, cancelButtonTitle: "OK!")
        Alert.show()
        
        slideshow.backgroundColor = UIColor.black
        slideshow.pageControlPosition = PageControlPosition.underScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
        
        //Segue to main lobby page when ready when the how to play is over
        slideshow.currentPageChanged = { page in
            if page == (self.localSource.capacity - 1){
                DispatchQueue.main.async {
                    let alert=UIAlertController(title: "Congrats!", message: "You are now ready to play Celebrities Squared! Click 'Let's Play' to enter!", preferredStyle: UIAlertControllerStyle.alert);
                    alert.addAction(UIAlertAction(title: "Let's Play!", style: UIAlertActionStyle.cancel, handler: {(action: UIAlertAction!) in
                        self.performSegue(withIdentifier: "htpMainLobbySegue", sender: self)
                    }));
                    //show it
                    self.show(alert, sender: self);
                }

            }
            if page < self.localSource.capacity-1{
                self.instText.text = self.instructions[page]
            }
            print("current page:", page)
        }

        //Set image sources
        slideshow.setImageInputs(localSource)
        slideshow.sizeToFit()
        
        instText.text = instructions[0]
        
        //Set Gesture recognizer for HowToPlay screen
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(HowToPlayScreen.didTap))
        slideshow.addGestureRecognizer(recognizer)
        
        
        //NEW CHANGES END        
    }
    
    //For when the screen is tapped to slide over to next image source
    func didTap(){
        //Set full screen controller
      //  slideshow.presentFullScreenController(from: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func mainlobbyClicked(_ sender: Any) {
        performSegue(withIdentifier: "htpMainLobbySegue", sender: self)
    }
    
    
    @IBAction func csButt(_ sender: Any) {
        performSegue(withIdentifier: "htpMainLobbySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "htpMainLobbySegue"{
            let DestViewController : SecondScreen = segue.destination as! SecondScreen
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
        }
    }
 

}
