//
//  ContestScreen.swift
//  CelebritiesSquared
//
//  Created by Dori Mouawad on 2/18/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//

import UIKit


class ContestScreen: UIViewController {

    var email = ""
    var contestName = ""
    var prizeURL = ""
    var desc = ""
    var goal = ""
    var current = ""
    var prize = ""
    var userName = ""
    var fundraiserImage = ""
    var prizeArray = [String]()
    var imgURLArray = [String]()
    var goalArray = [String]()
    var coinArray = [Int]()
    var videoIDArray = [String]()
    var currentArray = [String]()
    var costArray = [String]()
    var videoURLArray = [String]()
    var questionArray = [String]()
    var answerArray = [NSArray]() //Array<Array<Any>>()
    var contestType = ""
    var contestid = ""
    var tokenNum = ""
    var cost = ""
    var imgURL: NSURL!
    var imageURL = ""
    var responseString = ""
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descLabel: UITextView!
    
    @IBOutlet var progressButtOut: UIButton!
    @IBOutlet var outPlayNowButton: UIButton!
    
    final let urlString = "http://54.241.146.216/CSPhp/FullFundraiserInfo.php"

    override func viewDidLoad() {
        super.viewDidLoad()
      //  perform(Selector(ContestScreen), with: nil, afterDelay: 0)
        
        print("666contestScreen \(userName)")
        if contestType == "fundraiser" {
            progressButtOut.isHidden = true
            outPlayNowButton.setImage(UIImage(named: "button-play_for_ten")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        else if contestType == "vip" {
            progressButtOut.isHidden = true
            if cost == "1" {
            outPlayNowButton.setImage(UIImage(named: "button-play_for_one")?.withRenderingMode(.alwaysOriginal), for: .normal)
                
            }
            else if cost == "5" {
                outPlayNowButton.setImage(UIImage(named: "button-play_for_five")?.withRenderingMode(.alwaysOriginal), for: .normal)
                
            }


            else if cost == "10" {
                outPlayNowButton.setImage(UIImage(named: "button-play_for_ten")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
        else if contestType == "free" {
            progressButtOut.isHidden = true
            outPlayNowButton.setImage(UIImage(named: "button-play_for_free")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        //print(tokenNum)
        self.downloadJsonWithURL()
        downloadJsonWithURLCI()
        
        
        outPlayNowButton.isEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //contest substance?
    func downloadJsonWithURL(){
        //let url = NSURL(string: urlString)
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/FullFundraiserInfo.php")!)
        print("69696969 \(contestType)")
        if contestType == "fundraiser"{
            request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/FullFundraiserInfo.php")!)
        }
        else if contestType == "free"{
           request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/FullFreeContestInfo.php")!)
        }
        else if contestType == "vip"{
            request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/FullVIPContestInfo.php")!)
            print("GOT HERE")
        }
        
        request.httpMethod = "POST"
        
        var postString: String!
        postString = "name=\(contestName)"
        print(contestName)
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) ->
            Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                as? NSDictionary{
               // print(jsonObj!)
                
               // if let contestArray = jsonObj!.value(forKey: "contest") as? NSArray{
                
                    print("CONTS")
                    //print(contestArray)
                    //for contest in contestArray{

                      //  if let contestDict = contest as? NSDictionary{
                
                            //self.descLabel.text = "Contest Name: \(self.contestName)"
                
                            if let name = jsonObj!.value(forKey: "goal"){
                                self.goalArray.append((name as? String)!)
                            }
                            
                            
                            if let name = jsonObj!.value(forKey: "prize"){
                                self.prizeArray.append( (name as? String)!)

                            }
                
                            if let name = jsonObj!.value(forKey: "cost"){
                                self.costArray.append( (name as? String)!)
                                print("jhdbushbduinadia \(self.costArray)")
                    
                        }
                
                            if let name = jsonObj!.value(forKey: "current"){
                                self.currentArray.append( (name as? String)!)
                    
                            }
                
                            if let name = jsonObj!.value(forKey: "prizeURL"){
                                self.imgURLArray.append( (name as? String)!)
                                print("Heredear")
                                print(self.prizeArray)
                                if self.imgURLArray.count != 0{
                                let imgURL = NSURL(string: self.imgURLArray[0])
                                    if imgURL != nil{
                                        print("Heredear")
                                        print(self.prizeArray)
                                        let data = NSData(contentsOf: (imgURL as? URL)!)
                                        self.imageView.image = UIImage(data: data as! Data)
                                    }
                                    else {
                                        print("EMPTY")
                                    }
                                }
                               
                            }
                
                            OperationQueue.main.addOperation ({
                                self.setupUI()
                            })
                            
//
                        }
        }).resume()
    }
    
    //Contest Info
    func downloadJsonWithURLCI(){
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/FetchContestData.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        
        postString = "contestid=\(self.contestid)&type=\(self.contestType)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) ->
            Void in
            
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                as? NSDictionary{
                print(jsonObj)
                if let contestArray = jsonObj!.value(forKey: "questions") as? NSArray{
                    for contest in contestArray{
                        if let contestDict = contest as? NSDictionary{
                            if let name = contestDict.value(forKey: "videoid"){
                                self.videoIDArray.append(name as! String)
                                print("videoIDArray \(self.videoIDArray)")
                            }
                            if let name = contestDict.value(forKey: "videourl"){
                                self.videoURLArray.append(name as! String)
                                print("videoURLArray \(self.videoURLArray)")
                            }
                            
                            if let name = contestDict.value(forKey: "question"){
                                self.questionArray.append(name as! String)
                                print("questionArray \(self.questionArray)")
                            }
                            
                            if let name = contestDict.value(forKey: "answers"){
                                self.answerArray.append((name as! NSArray))
                                print("answerArray \(self.answerArray)")
                                //change the 0 to whichever question your on and get answer1-4
                                print("---------->\(type(of: self.answerArray[0].value(forKey: "answer1")))")
                                print("---------->\(type(of: self.answerArray[0]))")
                                
                            }
                            

                               }
                        }
                
                    
                    OperationQueue.main.addOperation ({
                        //self.tableView.reloadData()
                    })
       
            }
            }
            
        }).resume()
    }

    func postToServerFunction(){
        //Contingency Handling. Error handling etc.

        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/FullFundraiserInfo.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        postString = "name=\(contestName)"
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
            
            
            let responseString = String(data: data, encoding: .utf8)!
            print("responseString = \(responseString)")
            
            
            
            
        }
        task.resume()
    }
    
    //////////////////////////////////////////////////
    func setupUI(){
        //DispatchQueue.main.asyncAfter(deadline: .now() + 3.0 ) {

        if self.contestType == "fundraiser" {
            if(self.goalArray.count != 0){
                self.descLabel.text = "Charity Name:  \(self.contestName)  \n\nPrize Details: \(self.prizeArray[0])"
                
                if self.imgURLArray.count != 0{
                    imgURL = NSURL(string: self.imgURLArray[0])!
                    if imgURL != nil{
                        let data = NSData(contentsOf: (imgURL as? URL)!)
                        self.imageView.image = UIImage(data: data as! Data)
                    }
                }
            }
            else{
                self.descLabel.text = "Loading Data.."
            }
        }
        else if self.contestType == "free" {
            self.descLabel.text = "Contest Name:  \(self.contestName)  \n\nPrize Details: \(self.prize)"
            
            if self.imgURLArray.count != 0{
                imgURL = NSURL(string: self.imgURLArray[0])!
                if imgURL != nil{
                    let data = NSData(contentsOf: (imgURL as? URL)!)
                    self.imageView.image = UIImage(data: data as! Data)
                }
            }

        }
        else if self.contestType == "vip" {
            self.descLabel.text = "Contest Name:  \(self.contestName)  \n\nPrize Details: \(self.prize)"
            
            if self.imgURLArray.count != 0{
                imgURL = NSURL(string: self.imgURLArray[0])!
                if imgURL != nil{
                    let data = NSData(contentsOf: (imgURL as? URL)!)
                    self.imageView.image = UIImage(data: data as! Data)
                }
            }

        }
        
        if ((videoURLArray.count != 0) || (questionArray.count != 0) || (answerArray.count != 0)){
            outPlayNowButton.isEnabled = true
        }
    }
    
    func postToServerFunctionToken(token: Int){
        //Contingency Handling. Error handling etc.
        
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/SetToken.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        postString = "email=\(email)&token=\(token)"
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
        
        task.resume()
    }

    
    func postToServerFunctionCurrent(token: Int){
        //Contingency Handling. Error handling etc
    
        var request = URLRequest(url: URL(string: "http://54.241.146.216/CSPhp/SetCurrent.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        postString = "contestType=\(contestType)&token=\(token)&contestid=\(contestid)"
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
        
        task.resume()
    }

    
    @IBAction func playNowButt(_ sender: Any) {
        print("tokenNum \(tokenNum)")
        print(type(of:tokenNum))
        var check: Int = Int(tokenNum)!
        print("check \(check)")
        
        if contestType == "fundraiser"{
            if check >= 10 {
                check -= 10
                tokenNum = "\(check)"
                postToServerFunctionToken(token: check)
                postToServerFunctionCurrent(token: 10)
                self.performSegue(withIdentifier: "moveToGame", sender: self)
            
                   }
        else if check < 10 {
            self.performSegue(withIdentifier: "notEnoughTokens", sender: self)
        }
        
        else {
            print("FUCK THIS")
        }
        }
        else if contestType == "vip"{
            if videoURLArray.count < 0 {
                print("ERROR")
            }
            else {
                print("dugsuduwbdubwuyebdywbuyde \(cost)")
                if check >= Int(cost)! {
                    check -= Int(cost)!
                    print("gaydick \(check)")
                    tokenNum = "\(check)"
                    postToServerFunctionToken(token: check)
                    self.performSegue(withIdentifier: "moveToGame", sender: self)
                    
                }
                else if check < Int(cost)! {
                    self.performSegue(withIdentifier: "notEnoughTokens", sender: self)
                }
            }
        }
        else if contestType == "free" {
            self.performSegue(withIdentifier: "moveToGame", sender: self)
        }
        else {
            print("ERROR2")
        }
    }
    
    @IBAction func homeButt(_ sender: Any) {
        self.performSegue(withIdentifier: "contestToHome", sender: self)
        
    }
    
    @IBAction func backButt(_ sender: Any) {
        self.performSegue(withIdentifier: "backFromContest", sender: self)
    }
    
    
    @IBAction func progressButt(_ sender: Any) {
          self.performSegue(withIdentifier: "viewprogress", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToGame" {
            let DestViewController : ContestOverScreen = segue.destination as! ContestOverScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.contestName = contestName
            DestViewController.tokenNum = tokenNum
            DestViewController.videoURLArray = videoURLArray
            DestViewController.videoIDArray = videoIDArray
            DestViewController.answerArray = answerArray
            DestViewController.questionArray = questionArray
            DestViewController.contestType = contestType
            DestViewController.contestid = contestid
            DestViewController.userName = userName

            
            print(questionArray)
        }
        if segue.identifier == "backFromContest" {
            let DestViewController : FundraiserScreen = segue.destination as! FundraiserScreen
            DestViewController.email = email
            DestViewController.contestType = contestType
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
        }
        if segue.identifier == "viewprogress" {
            let DestViewController : ProgressScreen = segue.destination as! ProgressScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.contestName = contestName
            DestViewController.contestType = contestType
            DestViewController.tokenNum = tokenNum
            DestViewController.videoURLArray = videoURLArray
            DestViewController.videoIDArray = videoIDArray
            DestViewController.answerArray = answerArray
            DestViewController.questionArray = questionArray
            DestViewController.contestType = contestType
            DestViewController.contestid = contestid
            DestViewController.userName = userName
            DestViewController.cost = cost
            DestViewController.imgURLArray = imgURLArray
            DestViewController.prize = prize
            DestViewController.currentArray = currentArray
            DestViewController.fundraiserImage = fundraiserImage

        }
        if segue.identifier == "contestToHome" {
            let DestViewController : SecondScreen = segue.destination as! SecondScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
           
        }
        if segue.identifier == "notEnoughTokens" {
            let DestViewController : BuyTokenScreen = segue.destination as! BuyTokenScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
            
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
