//
//  SecondScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 8/19/16.
//  Copyright © 2016 Nick Hoyt. All rights reserved.
//

//import Foundation
import UIKit

class SecondScreen: UIViewController {
    var email = ""
    var tokenNum = ""
    var contestType = ""
    var userName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJsonWithURL()
        
        print("User" + email)
        print("tokenNum \(tokenNum)")
        
    }
    
    func downloadJsonWithURL(){
        //let url = NSURL(string: urlString)
        
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/Profiles.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        postString = "email=\(email)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) ->
            Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                as? NSDictionary{
                //print(jsonObj!)
                
                if let contestArray = jsonObj!.value(forKey: "profile") as? NSArray{
                    
                    for contest in contestArray{
                        if let contestDict = contest as? NSDictionary{
                            if let name = contestDict.value(forKey: "username"){
                                self.userName = (name as? String)!
                                print(self.userName)
                                
                            }
                            
                            if let name = contestDict.value(forKey: "coins"){
                                self.tokenNum = (name as? String)!
                                print(self.tokenNum)
                                
                            }
                        }
                        OperationQueue.main.addOperation ({
                            
                        })
                    }
                }
            }
        }).resume()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logoutButt(_ sender: Any) {
        email = ""
    }
    
    
    @IBAction func facebookButton(_ sender: AnyObject) {
        didTapFacebook(sender)
    }
    
    @IBAction func instagramButton(_ sender: AnyObject) {
        didTapInstagram(sender)
    }
    
    @IBAction func twitterButton(_ sender: AnyObject) {
        didTapTwitter(sender)
    }
    

    
    @IBAction func snapchatButton(_ sender: AnyObject) {
        didTapSnapchat(sender)
    }
    
    @IBAction func didTapFacebook(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: "https://www.facebook.com/CelebritiesSquared/?ref=aymt_homepage_panel")!)
    }
    
    @IBAction func didTapInstagram(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: "https://www.instagram.com/celebritiessquared/")!)
    }

    
    @IBAction func didTapTwitter(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: "https://twitter.com/CelebsSquared")!)
    }
    @IBAction func didTapSnapchat(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: "https://snapchat.com/add/CelebsSquared")!)
    }


    @IBAction func fundraiserButt(_ sender: Any) {
        
        contestType = "fundraiser"
        performSegue(withIdentifier: "fundraiserLobbySegue", sender: self)
        
    }
    
    @IBAction func vipButt(_ sender: Any) {
        print(email)
        contestType = "vip"
        performSegue(withIdentifier: "fundraiserLobbySegue", sender: self)
    }
    
    
    @IBAction func freeButt(_ sender: Any) {
        contestType = "free"
        performSegue(withIdentifier: "fundraiserLobbySegue", sender: self)
    }
    
    
    @IBAction func userButt(_ sender: Any) {
        performSegue(withIdentifier: "toProfile", sender: self)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToStart", sender: self)
        
    }
    
   
    @IBAction func logoutButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.set(false, forKey: "hasLogin")
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
    @IBAction func csLogoButt(_ sender: Any) {
        let Alert:UIAlertView = UIAlertView(title: "This is the Home button", message: "Click this button on the top of any screen (excluding during game play) to return to this home screen", delegate: self, cancelButtonTitle: "Gotcha!")
          Alert.show()
    }
    
    
    @IBAction func instructionButt(_ sender: AnyObject) {
            }
    
    @IBAction func disclaimerButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "secondToTerms", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       /* if segue.identifier == "contestLobbySegue" {
            let DestViewController : ThirdScreen = segue.destination as! ThirdScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
            
        } */
        if segue.identifier == "fundraiserLobbySegue" {
            let DestViewController : FundraiserScreen = segue.destination as! FundraiserScreen
            DestViewController.email = email
            DestViewController.contestType = contestType
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
        }
        
        else if segue.identifier == "comingsoon" {
            let DestViewController : ComingScreen = segue.destination as! ComingScreen
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
        }
        else if segue.identifier == "backToStart" {
            let DestViewController : StartScreen = segue.destination as! StartScreen
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
        }
        else if segue.identifier == "toProfile" {
            let DestViewController : ProfileScreen = segue.destination as! ProfileScreen
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
        }
        else if segue.identifier == "secondToTerms" {
            let DestViewController : TermsScreen = segue.destination as! TermsScreen
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
        }
    }

}

