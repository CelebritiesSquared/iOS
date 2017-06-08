//
//  ProfileScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 3/1/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//

import Foundation
import UIKit



class CelebProfileScreen: UIViewController {
    
    var email = ""
    var tokenNum = ""
    //var username = ""
    var userName = ""
   // var celebName = ""
    var contestName = ""
    var contestType = ""
    var celebname = ""
    var celebid = ""
    var profilePic = ""
    var website = ""
    var twitter = ""
    var insta = ""
    var facebook = ""
    var snapchat = ""
    var descriptionS = ""
    
    @IBOutlet var celebImage: UIImageView!
    
    @IBOutlet var celebNameLabel: UILabel!
    
    @IBOutlet var celebDescriptionLabel: UITextView!
   // @IBOutlet var celebWebsiteLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(celebid)
        downloadJsonWithURL()
        
    }
    
    
    //////new one
    
    func downloadJsonWithURL(){
        //let url = NSURL(string: urlString)
        
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/GetCelebData.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        postString = "celebid=\(celebid)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) ->
            Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                as? NSDictionary{
                print(jsonObj!)
                
            
                
                
                if let name = jsonObj!.value(forKey: "picture"){
                    if name is NSNull{
                        print("NO")
                    }
                    else {
                    self.profilePic = (name as? String)!
                    print(self.profilePic)
                    }
                }
                
                if let name = jsonObj!.value(forKey: "website"){
                    if name is NSNull{
                        print("NO")
                    }
                    else {
                    self.website = (name as? String)!
                    print(self.website)
                    }
                    
                }
                
                if let name = jsonObj!.value(forKey: "twitter"){
                    if name is NSNull{
                        print("NO")
                    }
                    else {
                    self.twitter = (name as? String)!
                    print(self.twitter)
                    }
                    
                }
                
                if let name = jsonObj!.value(forKey: "snapchat"){
                    if name is NSNull{
                        print("NO")
                    }
                    else {
                        self.snapchat = (name as? String)!
                        print(self.snapchat)
                    }
                    
                }
                
                if let name = jsonObj!.value(forKey: "instagram"){
                    if name is NSNull{
                    print("NO")
                    }
                    else {
                        self.insta = (name as? String)!
                        
                        print(self.insta)
                    }
                }
                
                
                if let name = jsonObj!.value(forKey: "facebook"){
                    if name is NSNull{
                        print("NO")
                    }
                    else {
                    self.facebook = (name as? String)!
                    print(self.facebook)
                    }
                }
                
                if let name = jsonObj!.value(forKey: "description"){
                    if name is NSNull{
                        print("NO")
                    }
                    else {
                    self.descriptionS = (name as? String)!
                    print(self.descriptionS)
                    }
                }
                if let name = jsonObj!.value(forKey: "name"){
                    if name is NSNull{
                        print("NO")
                    }
                    else {
                    self.celebname = (name as? String)!
                    print(self.celebname)
                    }
                }

                
                
                
                OperationQueue.main.addOperation ({
                    let imgURL = NSURL(string: self.profilePic)
                    if imgURL != nil{
                        let data = NSData(contentsOf: (imgURL as? URL)!)
                        self.celebImage.image = UIImage(data: data as! Data)
                    }
                    self.celebNameLabel.text = self.celebname
                    self.celebDescriptionLabel.text = self.descriptionS
                   // self.celebWebsiteLabel.text = self.website
                })
                
                //
            }
            //    }
            // }
            // }
            
        }).resume()
    }

    
    /////////////////////CHANGES PASSWORD////////////////////////////
    func postToServerFunction(email: String, pass: String){
        //Contingency Handling. Error handling etc.
        // email = emailField.text!
        //  var password : String = passwordField.text!
        
        
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/FullFundraiserInfo.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        postString = "email=\(email)&password=\(pass)"
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
            
        //    self.responseString = String(data: data, encoding: .utf8)!
        //    print("responseString = \(self.responseString)")
            
        }
    //    checkResponseString()
        task.resume()
    }
    
  
    
    
    
    @IBAction func backButt(_ sender: Any) {
        self.performSegue(withIdentifier: "fromCelebProfileToFund", sender: self)
    }
    
    
    @IBAction func homeButton(_ sender: Any) {
        self.performSegue(withIdentifier: "fromCelebProfile", sender: self)
    }
    

    @IBAction func websiteButton(_ sender: Any) {
        if !self.website.isEmpty{
            UIApplication.shared.openURL(URL(string: self.website)!)
        }
        else{
            displayDialog()
        }
    }
    
    @IBAction func didTapFacebook(_ sender: AnyObject) {
        if !self.facebook.isEmpty{
            UIApplication.shared.openURL(URL(string: self.facebook)!)
        }
        else{
            displayDialog()
        }
    }
    
    
    @IBAction func didTapSnapchat(_ sender: AnyObject) {
        if !self.snapchat.isEmpty{
            UIApplication.shared.openURL(URL(string: self.snapchat)!)
        }
        else{
            displayDialog()
        }
    }
    
    @IBAction func didTapInstagram(_ sender: AnyObject) {
        if !self.insta.isEmpty{
            UIApplication.shared.openURL(URL(string: self.insta)!)
        }
        else{
            displayDialog()
        }
    }
    
    
    @IBAction func didTapTwitter(_ sender: AnyObject) {
        if !self.twitter.isEmpty{
            UIApplication.shared.openURL(URL(string: self.twitter)!)
        }
        else{
            displayDialog()
        }
    }
    
    func displayDialog(){
        let alert=UIAlertController(title: "Oops!", message: "This celebrity does not have an account on this social media platform", preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil));
        //show it
        self.show(alert, sender: self);
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromCelebProfile" {
            let DestViewController : SecondScreen = segue.destination as! SecondScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
            
        }
        if segue.identifier == "fromCelebProfileToFund" {
            let DestViewController : FundraiserScreen = segue.destination as! FundraiserScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.contestName = contestName
            DestViewController.contestType = contestType
            DestViewController.userName = userName
            
        }
    }
    
    
}
