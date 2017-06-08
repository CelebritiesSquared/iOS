//
//  WinnerScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 2/19/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//


import UIKit
import FacebookShare

class WinnerScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    final let urlString = "http://dev.celebritiessquared.com/CSPhp/GetLeaderboard.php"
    // Data model: These strings will be the data for the table view cells
    var nameArray = [String]()
    var prizeArray = [String]()
    var imgURLArray = [String]()
    var goalArray = [String]()
    var rankArray = [String]()
    var userScoreArray = [String]()
    var email = ""
    var score = ""
    var totalScore = Double()
    var objects: NSMutableArray!
    var contestName = ""
    var tokenNum = ""
    var contestType = ""
    var contestid = ""
    var userName = ""
    //Search Bar Declarations
    let searchController = UISearchController(searchResultsController: nil)
    
    //Facebook ID pulled from Database
    var facebookID = ""
    var myContent = ""
    
    @IBOutlet var shareButtOut: UIButton!
    let image : UIImage = UIImage(named: "CS_logo.png")!


    
    // don't forget to hook this up from the storyboard
    //    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var userScoreLabel: UILabel!

    @IBOutlet var userRankLabel: UILabel!
    @IBOutlet var userUsernameLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("dfibufbue \(userName)")
       // MusicHelper.sharedHelper.playBackgroundMusic()
        totalScore = Double(String(format: "%.03f",totalScore))!
        
        if(self.totalScore != 0.0){
            scoreLabel.text = "Score: \(self.totalScore)"
           
        }
        else {
            scoreLabel.isHidden = true
            shareButtOut.isHidden = true
        }
       
        self.downloadJsonWithURL()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getHighScoreURL()
            self.updateUI()
        }
        
        let Alert:UIAlertView = UIAlertView(title: "Information", message: "All answers to questions are revealed once the contest is closed out. You can play each Contest as many times as you choose to try and improve your score and try to capture the highest score. In-App Purchase Tokens are required for each time you play a VIP Contest.", delegate: self, cancelButtonTitle: "Gotcha!")
        Alert.show()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func backButt(_ sender: Any) {
        self.performSegue(withIdentifier: "winnerToHome", sender: self)
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
        
        
        if(scoreLabel.text == userScoreArray[0]){
            myContent = "I just set a high score of \(totalScore) playing the \(contestName) contest on Celebrities Squared! I'm aiming to win the grand prize, come see if you can beat my score!"
        }else{
            myContent = "I just scored \(totalScore) playing the \(contestName) contest on Celebrities Squared! I'm trying to beat my score of \(userScoreArray[0]), come see if you can beat my score!"
        }
        
        let vc = UIActivityViewController(activityItems: [myContent, image], applicationActivities: nil)
        
        
        
        self.present(vc, animated: true, completion: nil)

    }

    
    
    @IBAction func homeButt(_ sender: Any) {
        self.performSegue(withIdentifier: "winnerToHome", sender: self)
    }
    
    func getHighScoreURL(){
        var url = URLRequest(url: URL(string: "http://dev.celebritiessquared.com/CSPhp/GetHighestScore.php")!)
        
        
        url.httpMethod = "POST"
        
        var postString: String!
        print(contestName)
        postString = "contestid=\(contestid)&type=\(contestType)&username=\(userName)&contestname=\(contestName)"
        url.httpBody = postString.data(using: String.Encoding.utf8)
        
        //////////////////////////////////////////////////////
        //  let url = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) ->
            Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                as? NSDictionary{
                
                print(jsonObj)
                if let contestArray = jsonObj!.value(forKey: "leader") as? NSArray{
                    for contest in contestArray{
                        if let contestDict = contest as? NSDictionary{
                            if let name = contestDict.value(forKey: "score"){
                                self.userScoreArray.append(name as! String)
                            }
                            
                            if let name = contestDict.value(forKey: "rank"){
                                self.rankArray.append(name as! String)
                                print("Here")
                            }
                            
                        }
                    }
                    
                    OperationQueue.main.addOperation ({
                        self.updateUI()
                    })
                }
            }
            
        }).resume()

    }
    
    func updateUI(){
        if rankArray.count != 0 {
        self.userRankLabel.text = "#\(self.rankArray[0])"
        self.userScoreLabel.text = self.userScoreArray[0]
        self.userUsernameLabel.text = self.userName
         }
        else {
            //self.userRankLabel.text = "#\(self.rankArray[0])"
            self.userScoreLabel.text = self.score
            self.userUsernameLabel.text = self.userName
        }
        
        
    }
    
    ////////////////////DORI STUFF/////////////////////////
    func downloadJsonWithURL(){
        ////////////////////////////TEST/////////////////////
        var url = URLRequest(url: URL(string: "http://dev.celebritiessquared.com/CSPhp/GetLeaderboard.php")!)
        
        url.httpMethod = "POST"
        
        var postString: String!
        print(contestName)
        print(contestid)
        postString = "contestname=\(contestName)&type=\(contestType)&id=\(contestid)"
        url.httpBody = postString.data(using: String.Encoding.utf8)

        //////////////////////////////////////////////////////
      //  let url = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) ->
            Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                as? NSDictionary{

                print(jsonObj)
                if let contestArray = jsonObj!.value(forKey: "leader") as? NSArray{
                    for contest in contestArray{
                        if let contestDict = contest as? NSDictionary{
                            if let name = contestDict.value(forKey: "username"){
                                self.nameArray.append(name as! String)
                            }
                            
                            if let name = contestDict.value(forKey: "score"){
                                self.goalArray.append(name as! String)
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
    
    func downloadJsonWithTask() {
        let url = NSURL(string: urlString)
        
        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print(jsonData)
        }).resume()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.celebName.text = String(nameArray[indexPath.row])
        cell.prizeLabel.text = "#" + String(indexPath.row + 1)
        cell.endLabel.text = String(goalArray[indexPath.row])
        
        
        // cell.viewButton.tag = indexPath.row
        //  cell.viewButton.addTarget(self, action: Selector("viewAction:"), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "contestscreenSegue", sender: self)
    }
    
    @IBAction func viewAction(sender: UIButton){
        //let contestName =
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MusicHelper.sharedHelper.stopBackgroundMusic()
        if segue.identifier == "winnerToHome" {
            var DestViewController : SecondScreen = segue.destination as! SecondScreen
            // doSomething(sender as! UIButton)
            // DestViewController.passedName = buttonName
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
            //self.dismiss(animated: true, completion: nil)
        }
    }
}

