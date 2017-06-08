//
//  FundraiserContests.swift
//  CelebritiesSquared
//
//  Created by Dori Mouawad on 2/10/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//

import UIKit

class FundraiserContests: UIViewController{
    let urlString = "http://dev.celebritiessquared.com/CSPhp/GetContests.php"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func downloadJsonWithURL(){
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) ->
            Void in
            
            print(data)
            
        }).resume()
    }
    
}
