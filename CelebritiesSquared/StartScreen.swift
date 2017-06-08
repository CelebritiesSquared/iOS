//
//  StartScreen.swift
//  CelebritiesSquared
//
//  Created by Dori Mouawad on 2/17/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//

import UIKit

class StartScreen: UIViewController {
    var email = ""
    var tokenNum = ""
    var userName = ""
    var responseString = ""
    //Social Media button declarations
    @IBOutlet var snapchatButton: UIButton!
    @IBOutlet var twitterButton: UIButton!
    @IBOutlet var instagramButton: UIButton!
    @IBOutlet var facebookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // MusicHelper.sharedHelper.playBackgroundMusic()
        self.downloadJsonWithURLToken()
        print(email)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        if(self.email == "" || self.responseString == "Failed"){
            self.performSegue(withIdentifier: "emailFailed", sender: self)
        }
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    //////////////////////////PULL TOKEN INFO///////////////////
    func downloadJsonWithURLToken(){
        //let url = NSURL(string: urlString)
        self.responseString = ""
        
        //Contingency Handling. Error handling etc.
        //      email = emailField.text!
        //     var password : String = passwordField.text!
        
        
        var request = URLRequest(url: URL(string: "http://dev.celebritiessquared.com/CSPhp/GetToken.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        postString = "email=\(email)"
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
            self.tokenNum = self.responseString
            print(self.tokenNum)
            
        }
        task.resume()
        

    }
    ///////////////////////////////////////////////////////////
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookButton(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "https://www.facebook.com/CelebritiesSquared/?ref=aymt_homepage_panel")!)
    }

    @IBAction func instagramButton(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "https://www.instagram.com/celebritiessquared/")!)
    }
    
    @IBAction func twitterButton(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "https://twitter.com/CelebsSquared")!)
    }
    @IBAction func snapchatButton(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "https://www.snapchat.com/add/CelebsSquared/")!)
    }
    
    @IBAction func mainlobbyButton(_ sender: Any) {
        performSegue(withIdentifier: "mainLobbySegue", sender: self)
    }
    @IBAction func howtoplayButton(_ sender: Any) {
        
        performSegue(withIdentifier: "howtoplaySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "mainLobbySegue"{
            let DestViewController : SecondScreen = segue.destination as! SecondScreen
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
        }
        else if segue.identifier == "howtoplaySegue"{
            let DestViewController : HowToPlayScreen = segue.destination as! HowToPlayScreen
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            
        }else if segue.identifier == "emailFailed"{
            let DestViewController : LoginScreen = segue.destination as! LoginScreen
        }
    }
}
