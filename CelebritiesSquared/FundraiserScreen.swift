//
//  FundraiserScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 2/2/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//
import UIKit
class FundraiserScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var urlString = ""
    
    // Data model: These strings will be the data for the table view cells
    var nameArray = [String]()
    var prizeArray = [String]()
    var imgURLArray = [String]()
    var goalArray = [String]()
    var costArray = [String]()
    var celebNameArray = [String]()
    var celebIDArray = [String]()
    var endDateArray = [String]()
    //var celebIDArray = [String]()
    var contestIDArray = [String]()
    var longPrizeArray = [String]()
    var websiteArray = [String]()
    var imageURL = ""
    var fundraiserImage = ""
    var rower = 0
    var email = ""
    var contestName = ""
    var contestType = ""
    var celebid = ""
    var celebname = ""
    var contestid = ""
    var userName = ""
    var cost = ""
    var prize = ""
    var objects: NSMutableArray!
    var tokenNum = ""
    
    //Search Bar Declarations
    let searchController = UISearchController(searchResultsController: nil)
    
 //   @IBOutlet var searchBar: UISearchBar!
    // don't forget to hook this up from the storyboard
//    @IBOutlet var tableView: UITableView!
    
   
    @IBOutlet var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        //searchController.searchBar.
        //print(contestType)
        
        if contestType == "fundraiser"{
            //fundraiser
            self.downloadJsonWithURLFR()
            
        }
        else if contestType == "vip"{
            //vip
           
            self.downloadJsonWithURLVIP()
        }
        else if contestType == "free"{
            //daily free
          
            self.downloadJsonWithURLDF()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.downloadJsonWithURLToken()
        print("666fundraiserScreen \(userName)")
       // print("0000000000 \(userName)")
        //print(self.celebIDArray)
       //  self.downloadJsonWithURL()
    //    searchController.searchResultsUpdater = self.tableView as! UISearchResultsUpdating?
   //     searchController.dimsBackgroundDuringPresentation = false
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /////////////////////////////////DORI STUFF//////////////////////////////////////////
    
    func downloadJsonWithURLFR(){
        urlString = "http://54.241.146.216/CSPhp/GetContests.php"//"http://dev.celebritiessquared.com/CSPhp/GetContests.php"
        let url = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) ->
            Void in
            
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                as? NSDictionary{
                //print(jsonObj)
                if let contestArray = jsonObj!.value(forKey: "contest") as? NSArray{
                    for contest in contestArray{
                        if let contestDict = contest as? NSDictionary{
                            if let name = contestDict.value(forKey: "contestid"){
                                self.contestIDArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "name"){
                                self.nameArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "shortPrize"){
                                self.prizeArray.append(name as! String)
                            }
                            
                            if let name = contestDict.value(forKey: "imageURL"){
                                self.imgURLArray.append(name as! String)
                            }
                            
                            if let name = contestDict.value(forKey: "website"){
                                self.websiteArray.append(name as! String)
                            }
                            
                            if let name = contestDict.value(forKey: "goal"){
                                self.goalArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "celebid"){
                                self.celebIDArray.append(name as! String)
                               // print("celebid \(name)")
                              // self.celebid = (name as! String)
                            }
                            if let name = contestDict.value(forKey: "end"){
                                self.endDateArray.append(name as! String)
                            }
                            
                           if let name = contestDict.value(forKey: "celebname"){
                           // print("celebname \(name)")
                            self.celebNameArray.append(name as! String)
                             //   self.celebname = (name as! String)
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
    ///////////////////////VIP////////////////////////////
    func downloadJsonWithURLVIP(){
        urlString = "http://54.241.146.216/CSPhp/GetVIPContests.php"
        let url = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) ->
            Void in
            
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                as? NSDictionary{
                //print(jsonObj)
                if let contestArray = jsonObj!.value(forKey: "contest") as? NSArray{
                    for contest in contestArray{
                        if let contestDict = contest as? NSDictionary{
                            if let name = contestDict.value(forKey: "contestid"){
                                self.contestIDArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "name"){
                                self.nameArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "shortPrize"){
                                self.prizeArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "prize"){
                                self.longPrizeArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "imageURL"){
                                self.imgURLArray.append(name as! String)
                            }
                            
                            if let name = contestDict.value(forKey: "cost"){
                                self.costArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "goal"){
                                self.goalArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "website"){
                                self.websiteArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "celebid"){
                                self.celebIDArray.append(name as! String)
                                //print("celebid \(name)")
                                // self.celebid = (name as! String)
                            }
                            if let name = contestDict.value(forKey: "celebname"){
                                //print("celebname \(name)")
                                self.celebNameArray.append(name as! String)
                                //   self.celebname = (name as! String)
                            }
                            
                            if let name = contestDict.value(forKey: "end"){
                                self.endDateArray.append(name as! String)
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
    
    //////////////////////////////////////////////////////
    
    ///////////////////////Daily Free////////////////////////////
    func downloadJsonWithURLDF(){
        urlString = "http://54.241.146.216/CSPhp/GetFreeContests.php"
        let url = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) ->
            Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                as? NSDictionary{
                //print(jsonObj)
                if let contestArray = jsonObj!.value(forKey: "contest") as? NSArray{
                    for contest in contestArray{
                        if let contestDict = contest as? NSDictionary{
                            if let name = contestDict.value(forKey: "contestid"){
                                self.contestIDArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "name"){
                                self.nameArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "shortPrize"){
                                self.prizeArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "prize"){
                                self.longPrizeArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "imageURL"){
                                self.imgURLArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "website"){
                                self.websiteArray.append(name as! String)
                            }
                            if let name = contestDict.value(forKey: "goal"){
                                self.goalArray.append(name as! String)
                            }
                            
                            if let name = contestDict.value(forKey: "end"){
                                self.endDateArray.append(name as! String)
                            }
                            
                            if let name = contestDict.value(forKey: "celebid"){
                                self.celebIDArray.append(name as! String)
                              //  print("celebid \(name)")
                                // self.celebid = (name as! String)
                            }
                            if let name = contestDict.value(forKey: "celebname"){
                                self.celebNameArray.append(name as! String)
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
    
    //////////////////////////////////////////////////////

    func downloadJsonWithTask() {
        let url = NSURL(string: urlString)
        
        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            //print(jsonData)
        }).resume()
    }
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return nameArray.count
    }
    
    func celebNameTapped(sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: self.tableView)
        
        //using the tapLocation, we retrieve the corresponding indexPath
        if let indexPath = self.tableView.indexPathForRow(at: tapLocation){
            //print("indexrow \(indexPath.row)")
            celebid = celebIDArray[(indexPath.row)]
             self.performSegue(withIdentifier: "toCelebProfile", sender: self)
        }
    }
    
    func fundImageTapped(sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: self.tableView)
        //print("COCK")
        //using the tapLocation, we retrieve the corresponding indexPath
        if let indexPath = self.tableView.indexPathForRow(at: tapLocation){
         
        UIApplication.shared.openURL(URL(string: websiteArray[indexPath.row])!)
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let tap = UITapGestureRecognizer(target: self, action: #selector(FundraiserScreen.celebNameTapped))
        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(FundraiserScreen.fundImageTapped))
        cell.nameLabel.text = nameArray[indexPath.row]
        cell.prizeLabel.text = "Prize: " + prizeArray[indexPath.row]
        if contestType == "fundraiser"{
            cell.goalLabel.isHidden = true
           // cell.goalLabel.text = "Goal: $" + goalArray[indexPath.row]
            cell.celebName.text = celebNameArray[indexPath.row]
            cell.celebid = celebIDArray[indexPath.row]
            //cell.endLabel.isHidden = true
            if endDateArray.count != 0 {
            cell.endLabel.text = "Ends: \(endDateArray[indexPath.row])"
            }
            else{
                cell.endLabel.text = ""
            }
            cell.celebName.addGestureRecognizer(tap)
            cell.imageV.isUserInteractionEnabled = true
            cell.imageV.addGestureRecognizer(imageTapped)
        }
        else if contestType == "free" {
            cell.goalLabel.text = "To Play: Free" //+ goalArray[indexPath.row]
            cell.endLabel.isHidden = false
            cell.endLabel.text = "Ends: \(endDateArray[indexPath.row])"
            cell.celebName.text = celebNameArray[indexPath.row]
            cell.celebName.addGestureRecognizer(tap)
            cell.celebid = celebIDArray[indexPath.row]
      //      cell.imageV.isUserInteractionEnabled = true
        //    cell.imageV.addGestureRecognizer(imageTapped)
        }
        else if contestType == "vip" {
            if costArray[indexPath.row] == "1"{
                cell.goalLabel.text = "To Play: \(costArray[indexPath.row]) token"
            }else{
                cell.goalLabel.text = "To Play: \(costArray[indexPath.row]) tokens"
            }
            cell.endLabel.isHidden = false
            cell.endLabel.text = "Ends: \(endDateArray[indexPath.row])"
            cell.celebName.text = celebNameArray[indexPath.row]
            cell.celebName.addGestureRecognizer(tap)
            cell.celebid = celebIDArray[indexPath.row]
         //   cell.imageV.isUserInteractionEnabled = true
         //   cell.imageV.addGestureRecognizer(imageTapped)
        }
        
        let imgURL = NSURL(string: imgURLArray[indexPath.row])
        
        if imgURL != nil{
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.imageView!.image = UIImage(data: data as! Data)
        }
        
        cell.viewButton.tag = indexPath.row
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       contestName = self.nameArray[indexPath.row]
        celebname = self.celebNameArray[indexPath.row]
        //print("r32432423 \(contestIDArray)")
        
        contestid = contestIDArray[indexPath.row]
        
        if contestType == "fundraiser"{
            self.fundraiserImage = imgURLArray[indexPath.row]
            self.performSegue(withIdentifier: "contestscreenSegue", sender: self)
        }
        else if contestType == "free"{
            ///// CHANGE HERE TO MAKE IT GO STRAIGHT TO GAME OR MODIFIED FUNDRAISER INFO SCREEN
            self.imageURL = imgURLArray[indexPath.row]
            self.prize = longPrizeArray[indexPath.row]
            self.performSegue(withIdentifier: "contestscreenSegue", sender: self)
        }
        else if contestType == "vip"{
            self.cost = costArray[indexPath.row]
            self.imageURL = imgURLArray[indexPath.row]
            self.prize = longPrizeArray[indexPath.row]
            self.performSegue(withIdentifier: "contestscreenSegue", sender: self)
            ///// CHANGE HERE TO MAKE IT GO STRAIGHT TO GAME OR MODIFIED FUNDRAISER INFO SCREEN
        }
        
    }
 
    
    //////////////////////////PULL TOKEN INFO///////////////////
    func downloadJsonWithURLToken(){
        //let url = NSURL(string: urlString)
        var responseString = ""
        
        
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
            
            responseString = String(data: data, encoding: .utf8)!
            //print("responseString = \(responseString)")
            self.tokenNum = responseString
           // print(self.tokenNum)
            
        }
        
        task.resume()
    }
    ///////////////////////////////////////////////////////////
    

    @IBAction func csButt(_ sender: Any) {
        self.performSegue(withIdentifier: "backFromFund", sender: self)
    }
    
    @IBAction func backButt(_ sender: Any) {
        self.performSegue(withIdentifier: "backFromFund", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MusicHelper.sharedHelper.stopBackgroundMusic()
//        if segue.identifier == "backFromFund" {
//            var DestViewController : SecondScreen = segue.destination as! SecondScreen
//            // doSomething(sender as! UIButton)
//            // DestViewController.passedName = buttonName
//             DestViewController.email = email
//        }
//        else{
        
        if segue.identifier == "contestscreenSegue"{
            let DestViewController : ContestScreen = segue.destination as! ContestScreen
            //doSomething(sender as! UIButton)
           // DestViewController.passedName = buttonName
            DestViewController.email = email
            DestViewController.contestName = contestName
            DestViewController.contestType = contestType
            DestViewController.tokenNum = tokenNum
            DestViewController.contestid = contestid
            DestViewController.userName = userName
            DestViewController.cost = cost
            DestViewController.prize = prize
            DestViewController.imageURL = imageURL
            DestViewController.fundraiserImage = fundraiserImage
           // print("contestid \(contestid)")
        }
        else if segue.identifier == "comingSoonSegue"{
            let DestViewController : ComingScreen = segue.destination as! ComingScreen
            //doSomething(sender as! UIButton)
            // DestViewController.passedName = buttonName
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
            
        }
        else if segue.identifier == "backFromFund"{
            let DestViewController : SecondScreen = segue.destination as! SecondScreen
            //doSomething(sender as! UIButton)
            // DestViewController.passedName = buttonName
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
            
        }
        else if segue.identifier == "toCelebProfile"{
            let DestViewController : CelebProfileScreen = segue.destination as! CelebProfileScreen
            //doSomething(sender as! UIButton)
            // DestViewController.passedName = buttonName
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.contestName = contestName
            DestViewController.contestType = contestType
            DestViewController.celebname = celebname
            DestViewController.celebid = celebid
            DestViewController.userName = userName
           // print(celebid)
           // print(celebname)
    }
    }
}

