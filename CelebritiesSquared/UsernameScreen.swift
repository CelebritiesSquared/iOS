//
//  UsernameScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 10/5/16.
//  Copyright © 2016 Nick Hoyt. All rights reserved.
//

import UIKit

class UsernameScreen: UIViewController {
    
    
    
    
    //    @IBAction func contestLobbyButton(sender: AnyObject) {
    //       var alert = UIAlertController(title: "ALERT", message: "Enter Username", preferredStyle: UIAlertControllerStyle.Alert)
    //
    //
    //       self.presentViewController(alert, animated: true, completion: nil)
    //
    //    }
    var userName = ""
    
    
    
    //@IBOutlet var userNameField: UITextField!
    
    @IBOutlet var userNameField: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        var Alert:UIAlertView = UIAlertView(title: "Test", message: ", delegate: self, cancelButtonTitle: "OK")
        //        Alert.show()
        //1. Create the alert controller.
        //print(NSUserDefaults.standardUserDefaults().dictionaryRepresentation());
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
    
    

   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        userNameField.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func userNameButton(_ sender: AnyObject) {
        if userNameField.text == "" || userNameField.text == " "{
            let Alert:UIAlertView = UIAlertView(title: "Oops!", message: "Don\'t forget to enter a Username!", delegate: self, cancelButtonTitle: "OK")
            Alert.show()
        }
        else{
            performSegue(withIdentifier: "usernameEntered", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "usernameEntered" {
            let DestViewController : ThirdScreen = segue.destination as! ThirdScreen
            // doSomething(sender as! UIButton)
            DestViewController.userName = userNameField.text!
            
        }
        
    }

}
