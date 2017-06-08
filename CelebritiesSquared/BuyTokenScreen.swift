//
//  BuyTokenScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 3/1/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

var sharedSecret = "cf577011d9ee42a8b71fd16df658db57"

enum RegisteredPurchase : String {
    case tenDollar = "Ten Token Bundle"
}



class BuyTokenScreen: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    var tokenNum = ""
    var email = ""
    var userName = ""
    var responseString = ""
    // @IBOutlet var lblAd: UILabel!
    
    //let settingsVC = SettingsViewController()
    
    @IBOutlet var lblCoinAmount: UILabel!
    
    //  @IBOutlet var outRemoveAds: UIButton!
    @IBOutlet var outAddCoins: UIButton!
    
    @IBOutlet var outAddOneCoin: UIButton!
    
    
    @IBOutlet var outAddFiveCoins: UIButton!
    
    @IBOutlet var outAddFiftyCoins: UIButton!
    
    @IBOutlet var outRestorePurchases: UIButton!
    
    //  var coins = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // outRemoveAds.isEnabled = false
        print(tokenNum)
       lblCoinAmount.text = tokenNum
        outAddCoins.isEnabled = false
        outAddOneCoin.isEnabled = false
        outAddFiveCoins.isEnabled = false
        outAddFiftyCoins.isEnabled = false
        outRestorePurchases.isEnabled = false
        print(tokenNum)
        if(SKPaymentQueue.canMakePayments()) {
            print("IAP is enabled, loading")
            let productID: NSSet = NSSet(objects: "com.CelebritiesSquared.CelebritiesSquaredApp.addFifty", "com.CelebritiesSquared.CelebritiesSquaredApp.addOne", "com.CelebritiesSquared.CelebritiesSquaredApp.addFive", "com.CelebritiesSquared.CelebritiesSquaredApp.addTen")
            let request: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            print("please enable IAPS")
        }
    }
    /*
     @IBAction func btnRemoveAds(_ sender: Any) {
     print("rem ads")
     for product in list {
     let prodID = product.productIdentifier
     if(prodID == "seemu.iap.removeads") {
     p = product
     buyProduct()
     }
     }
     }
     */
    
    
    
    
    /* Put in token coming soon
     let alert=UIAlertController(title: "Coming Soon", message: "More Token Bundles Coming Soon!", preferredStyle: UIAlertControllerStyle.alert);
     alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil));
     //show it
     self.show(alert, sender: self);
     
     
     */

    
    
    @IBAction func btnAddOneCoin(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "http://celebritiessquared.com/testStripe/indexOne.html")!)
    
        //stripe
        /*
        let checkoutViewController = CheckoutViewController(price: 100, settings: self.settingsVC.settings, email: self.email, tokenNum: self.tokenNum)
        
        self.present(checkoutViewController, animated: true, completion: nil)
        */
        
        //iap
        /*
        print(list)
        for product in list {
            let prodID = product.productIdentifier
            print(prodID)
            if(prodID == "com.CelebritiesSquared.CelebritiesSquaredApp.addOne") {
                p = product
                buyProduct()
            }
        }
        
        */
        
    }
    
    
    @IBAction func btnAddFiveCoins(_ sender: Any) {
         UIApplication.shared.openURL(URL(string: "http://celebritiessquared.com/testStripe/indexFive.html")!)
//stripe
/*
        let checkoutViewController = CheckoutViewController(price: 500, settings: self.settingsVC.settings, email: self.email, tokenNum: self.tokenNum)
        
        self.present(checkoutViewController, animated: true, completion: nil)
        */
         //iap
        /*
        print(list)
        for product in list {
            let prodID = product.productIdentifier
            print(prodID)
            if(prodID == "com.CelebritiesSquared.CelebritiesSquaredApp.addFive") {
                p = product
                buyProduct()
            }
        }
 */
    }
    
    
    @IBAction func btnAddFiftyCoins(_ sender: Any) {
         UIApplication.shared.openURL(URL(string: "http://celebritiessquared.com/testStripe/indexFifty.html")!)
        
//stripe
/*
        let checkoutViewController = CheckoutViewController(price: 5000, settings: self.settingsVC.settings, email: self.email, tokenNum: self.tokenNum)
        
        self.present(checkoutViewController, animated: true, completion: nil)
        */
         //iap
        /*
        print(list)
        for product in list {
            let prodID = product.productIdentifier
            print(prodID)
            if(prodID == "com.CelebritiesSquared.CelebritiesSquaredApp.addFifty") {
                p = product
                buyProduct()
            }
        }
 */
    }
    
    //adds ten tokens
    @IBAction func btnAddCoins(_ sender: Any) {
         UIApplication.shared.openURL(URL(string: "http://celebritiessquared.com/testStripe/indexTen.html")!)
        
//stripe
/*
        let checkoutViewController = CheckoutViewController(price: 1000, settings: self.settingsVC.settings, email: self.email, tokenNum: self.tokenNum)
        
        self.present(checkoutViewController, animated: true, completion: nil)
        */
         //iap
        /*
        print(list)
        for product in list {
            let prodID = product.productIdentifier
            print(prodID)
            if(prodID == "com.CelebritiesSquared.CelebritiesSquaredApp.addTen") {
                p = product
                buyProduct()
            }
        }
 */
    }
    
    @IBAction func btnRestorePurchases(_ sender: Any) {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
    
    func buyProduct() {
        print("buy " + p.productIdentifier)
        let pay = SKPayment(product: p)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(pay as SKPayment)
    }
    
    func removeAds() {
        //  lblAd.removeFromSuperview()
    }
    
    func addCoins(coins: Int) {
        
        var check: Int = Int(tokenNum)!
        check += coins
        lblCoinAmount.text = "\(check)"
        tokenNum = "\(check)"
        postToServerFunction()
    }
    
    var list = [SKProduct]()
    var p = SKProduct()
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("product request")
        let myProduct = response.products
        for product in myProduct {
            print("product added")
            print(product.productIdentifier)
            print(product.localizedTitle)
            print(product.localizedDescription)
            print(product.price)
            
            list.append(product)
        }
        
        //  outRemoveAds.isEnabled = true
        outAddCoins.isEnabled = true
        
        outAddOneCoin.isEnabled = true
        outAddFiveCoins.isEnabled = true
        outAddFiftyCoins.isEnabled = true
        outRestorePurchases.isEnabled = true
    }
    
    func postToServerFunction(){
        //Contingency Handling. Error handling etc.
        
        
        //var uw : String = username.text!
        
        
        var request = URLRequest(url: URL(string: "http://dev.celebritiessquared.com/CSPhp/SetToken.php")!)
        
        request.httpMethod = "POST"
        
        var postString: String!
        postString = "email=\(email)&token=\(tokenNum)"
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
    
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("transactions restored")
        print(queue.transactions)
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction
            let prodID = t.payment.productIdentifier as String
            
            switch prodID {
                /* case "seemu.iap.removeads":
                 print("remove ads")
                 removeAds()
                 */
            case "com.CelebritiesSquared.CelebritiesSquaredApp.addTen":
                print("add coins to account")
                addCoins(coins: 10)
            case "com.CelebritiesSquared.CelebritiesSquaredApp.addOne":
                print("add coins to account")
                addCoins(coins: 1)
            case "com.CelebritiesSquared.CelebritiesSquaredApp.addFive":
                print("add coins to account")
                addCoins(coins: 5)
            case "com.CelebritiesSquared.CelebritiesSquaredApp.addFifty":
                print("add coins to account")
                addCoins(coins: 50)
            default:
                print("IAP not found")
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("add payment")
        
        for transaction: AnyObject in transactions {
            let trans = transaction as! SKPaymentTransaction
            print(trans.error)
            
            switch trans.transactionState {
            case .purchased:
                print("buy ok, unlock IAP HERE")
                print(p.productIdentifier)
                
                let prodID = p.productIdentifier
                switch prodID {
                    /* case "seemu.iap.removeads":
                     print("remove ads")
                     removeAds()
                     */
                case "com.CelebritiesSquared.CelebritiesSquaredApp.addTen":
                    print("add coins to account")
                    addCoins(coins: 10)
                case "com.CelebritiesSquared.CelebritiesSquaredApp.addOne":
                    print("add coins to account")
                    addCoins(coins: 1)
                case "com.CelebritiesSquared.CelebritiesSquaredApp.addFive":
                    print("add coins to account")
                    addCoins(coins: 5)
                case "com.CelebritiesSquared.CelebritiesSquaredApp.addFifty":
                    print("add coins to account")
                    addCoins(coins: 50)
                default:
                    print("IAP not found")
                }
                queue.finishTransaction(trans)
            case .failed:
                print("buy error")
                queue.finishTransaction(trans)
                break
            default:
                print("Default")
                break
            }
        }
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "fromPurchaseToken", sender: self)
    }
    
    @IBAction func homeButt(_ sender: Any) {
        self.performSegue(withIdentifier: "purchaseToMain", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromPurchaseToken" {
            let DestViewController : ProfileScreen = segue.destination as! ProfileScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
        }
        if segue.identifier == "purchaseToMain" {
            let DestViewController : SecondScreen = segue.destination as! SecondScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
        }
        /*
        if segue.identifier == "buyToCredit" {
            let DestViewController : CreditCardScreen = segue.destination as! CreditCardScreen
            // doSomething(sender as! UIButton)
            DestViewController.email = email
            DestViewController.tokenNum = tokenNum
            DestViewController.userName = userName
        } */
    }
    
    
}

