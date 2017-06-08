//
//  ProfileScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 3/1/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit


class ProfileScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, FBSDKLoginButtonDelegate {
    
    var email = ""
    var tokenNum = ""
    var first = ""
    var last = ""
    var age = ""
   // var username = ""
    var responseString = ""
    var contestType = ""
    var contestid = ""
    var contestName = ""
    var userName = ""
    var score = ""
    var scoreArray = [String]()
    var contestNameArray = [String]()
    var contestIDArray = [String]()
    var allowed = false
    
    let MyKeyChainWrapper = KeychainWrapper()

    
    @IBOutlet var loginView: LoginButton!
    //fb vars
    var  fbResponseString = ""
    var fbFirst : String = ""
    var fbLast : String = ""
    var fbId : String = ""
    var fbUser = false
    var fbEmail : String = ""
    ///
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var namelabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var tokenLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var contestIDCellLabel: UILabel!
    
    @IBOutlet var contestNameCellLabel: UILabel!
    
    @IBOutlet var contestScoreCellLabel: UILabel!
    
    let loginbutton = FBSDKLoginButton()
    let loginManager = FBSDKLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Checks if Facebook user is in DB then hides button if yes
        loginbutton.isHidden = true
        self.checkFacebookDB()
        
        downloadJsonWithURL()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.downloadJsonWithURLAllScores()
        }
        //let loginManager = FBSDKLoginManager()
        //loginManager.logOut()
        
        //let loginbutton = FBSDKLoginButton()
        view.addSubview(loginbutton)
        loginbutton.frame = CGRect(x: 0.0, y: self.view.frame.size.height - 30, width: view.frame.width, height: 30)
        
        //Delegate to self and set read permissions
        loginbutton.delegate = self
        loginbutton.readPermissions = ["email", "public_profile"]
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        //Print successful in log in was correct
        print("Successfully logged in with facebook.")
        
        //Graph Request for desired fields
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, first_name, last_name, email, friends"]).start { (connection, result, err) in
            
            if err != nil{
                print("Failed to start graph request:", err)
                return
            }
            
            if result != nil{
                //DATA PARSING HERE
                let data:[String:AnyObject] = result as! [String : AnyObject]
                
                //Stores email, first name, and last name
                self.fbEmail = data["email"] as! String!
                self.fbFirst = data["first_name"] as! String!
                self.fbLast = data["last_name"] as! String!
                self.fbId = data["id"] as! String!
                
                self.postToFacebookServer()
            }
        }
    }
    
    
    func getToken() -> String{
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/GetToken.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        var res : String!
        
        postString = "email=\(fbEmail)"
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
            
            res = String(data: data, encoding: .utf8)!
            print("response = \(res)")
            
            if(res != "Failed")
            {
                self.tokenNum = res
            }
            else{
                self.tokenNum = "null"
            }
        }
        task.resume()
        
        return self.tokenNum
    }

    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of Facebook")
    }

    
    //Check if is a Facebook user in Database
    func checkFacebookDB(){
        
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/IsFacebookUser.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        self.responseString = ""
        
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
            print("response = \(self.responseString)")
        }
        
        task.resume()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.checkFBresponse()
        }
    }

    func checkFBresponse(){
        print(fbUser)
        print("Here: \(self.responseString)")
        if(self.responseString == "True"){
            loginbutton.isHidden = true
            loginbutton.isUserInteractionEnabled = false
        }
        else{
            loginManager.logOut()
            loginbutton.isHidden = false
            loginbutton.isUserInteractionEnabled = true
        }
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
                print(jsonObj!)
                
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
                
                if let name = contestDict.value(forKey: "first"){
                    self.first = (name as? String)!
                    
                    print(self.first)
                }
                
                
                if let name = contestDict.value(forKey: "last"){
                    self.last = (name as? String)!
                    print(self.last)
                }
                

                        }
                        OperationQueue.main.addOperation ({
                           // self.namelabel.text = " Username: \(self.username)\n Name: \(self.first) \(self.last)\n Age: \(self.age)\n Tokens: \(self.tokenNum)"
                            self.namelabel.text = "\(self.first) \(self.last)"
                            self.usernameLabel.text = self.userName
                            self.tokenLabel.text = self.tokenNum
                        })
                    }
                }
            }
        }).resume()
    }
    
    
    ////facebook link
    func postToFacebookServer(){
        
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/CreateFacebookUser.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        self.fbResponseString = ""
        
        print(fbId)
        
        postString = "fbId=\(fbId)&email=\(email)"
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
            
            self.fbResponseString = String(data: data, encoding: .utf8)!
            print("fbResponseString = \(self.fbResponseString)")
        }
        task.resume()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.fbResponseString == "Success"{
                self.loginbutton.isHidden = true
                let alert=UIAlertController(title: "Success!", message: "Successfully Linked Facebook Account! You can now login through Facebook on the login screen!", preferredStyle: UIAlertControllerStyle.alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil));
                //show it
                self.show(alert, sender: self);
            }
            else{
                //Segue to register screen if not in Facebook database
                let alert=UIAlertController(title: "Oops!", message: "Failed to Link Facebook Account", preferredStyle: UIAlertControllerStyle.alert);
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil));
                //show it
                self.show(alert, sender: self);
            }
        }
    }
    
    ///////////
    func downloadJsonWithURLAllScores(){
        //let url = NSURL(string: urlString)
        
        var url = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/GetAllScores.php")!)
        
        url.httpMethod = "POST"
        
        var postString: String!
        
        postString = "username=\(userName)"
        url.httpBody = postString.data(using: String.Encoding.utf8)
        
        //////////////////////////////////////////////////////
        //  let url = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) ->
            Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                as? NSDictionary{
                
                print(jsonObj!)
                if let contestArray = jsonObj!.value(forKey: "leader") as? NSArray{
                    for contest in contestArray{
                        if let contestDict = contest as? NSDictionary{
                            
                            if let name = contestDict.value(forKey: "score"){
                                self.scoreArray.append(name as! String)
                            }
                            
                            
                            if let name = contestDict.value(forKey: "contestid"){
                                self.contestIDArray.append(name as! String)
                                print(self.contestIDArray)
                            }
                            
                            if let name = contestDict.value(forKey: "contestname"){
                                self.contestNameArray.append(name as! String)
                                print(self.contestNameArray)
                            }
                            
                        }
                    }
                    
                    OperationQueue.main.addOperation ({
                        self.tableView.reloadData()
                    })
                }
            }
            
        }).resume()
    }

    
    /////////////////////CHANGES PASSWORD////////////////////////////
    func postToServerFunction(email: String, pass: String){
        //Contingency Handling. Error handling etc.
       // email = emailField.text!
      //  var password : String = passwordField.text!
        
        
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/ChangePassword.php")!)
        
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
            
            self.responseString = String(data: data, encoding: .utf8)!
            print("responseString = \(self.responseString)")
            
        }
        checkResponseString()
        task.resume()
    }
    
    ///////////////////
    
    func checkResponseString(){
        print(allowed)
        if(self.responseString == "Success"){
            allowed = true
            
        }
        else{
            allowed = false
        }
    }
    
    ///////////////////END CHANGE PASSWORD//////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       // print(contestIDArray.count)
        return contestNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProfileTableViewCell
        print("kdnisndns \(contestNameArray[indexPath.row])")
        // print("kdnisndns \(contestIDArray[indexPath.row])")
        cell.contestNameCellLabel.text = contestNameArray[indexPath.row]
     //   cell.contestIDCellLabel.text = "ID: \(contestIDArray[indexPath.row])"
        cell.contestScoreCellLabel.text = scoreArray[indexPath.row]
        
        // cell.viewButton.tag = indexPath.row
        //  cell.viewButton.addTarget(self, action: Selector("viewAction:"), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.contestid = self.contestIDArray[indexPath.row]
        self.contestName = self.contestNameArray[indexPath.row]
        self.score = self.scoreArray[indexPath.row]
       
        self.performSegue(withIdentifier: "profileToWinner", sender: self)
        
    }

    
///////////////////////////////////

    @IBAction func changePassButt(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Change Password", message: "Enter New Password", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        
        alert.addTextField { (textField) in
            textField.placeholder = "New Password"
            textField.isSecureTextEntry = true
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Confirm New Password"
            textField.isSecureTextEntry = true
        }
        let newPass = alert.textFields![0]
        let confNewPass = alert.textFields![1]
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            
            if (newPass.text)! == (confNewPass.text)! && ((newPass.text)!).characters.count >= 6{
                self.postToServerFunction(email: self.email, pass: newPass.text!)
                print("SUCCESSFUL CHANGED")
                print(newPass.text!)
                self.MyKeyChainWrapper.mySetObject(newPass.text!, forKey:kSecValueData)
                let Alert:UIAlertView = UIAlertView(title: "Password", message: "Password Successfully Changed", delegate: self, cancelButtonTitle: "OK")
                Alert.show()
            }
            else{
                if ((newPass.text)!).characters.count < 6 {
                    let Alert:UIAlertView = UIAlertView(title: "Error", message: "Password Must be greater than 6 characters", delegate: self, cancelButtonTitle: "OK")
                    Alert.show()
                }
                else if ((newPass.text)!).characters.count >= 6 {
                    print("FAILURE")
                    let Alert:UIAlertView = UIAlertView(title: "Error", message: "Make Sure Passwords Match", delegate: self, cancelButtonTitle: "OK")
                    Alert.show()
                }
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
            //let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
           // print("Text field: \(textField?.text)")
        }))

        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "fromProfile", sender: self)
    }
    
    
    @IBAction func infoButton(_ sender: AnyObject) {
        didTapInfo(sender)
    }
    
    
    @IBAction func didTapInfo(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: "https://www.celebritiessquared.com/")!)
    }
    
    
    @IBAction func homeButt(_ sender: Any) {
        self.performSegue(withIdentifier: "fromProfile", sender: self)
    }
    
    
    @IBAction func purchaseTokenButt(_ sender: Any) {
        self.performSegue(withIdentifier: "toPurchaseToken", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromProfile" {
            let DestViewController : SecondScreen = segue.destination as! SecondScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
            
        }
        if segue.identifier == "toPurchaseToken" {
            let DestViewController : BuyTokenScreen = segue.destination as! BuyTokenScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
            
        }
        if segue.identifier == "profileToWinner" {
            let DestViewController : WinnerScreen = segue.destination as! WinnerScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.contestid = contestid
            DestViewController.contestName = contestName
            DestViewController.contestType = contestType
            DestViewController.totalScore = 0.0
            DestViewController.userName = userName
            DestViewController.score = score
            
        }
    }
    
    
}
