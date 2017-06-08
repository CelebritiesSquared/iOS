//
//  FourthScreen.swift
//  CelebritiesSquared
//
//  Created by Nick Hoyt on 9/11/16.
//  Copyright © 2016 Nick Hoyt. All rights reserved.
//

//import Foundation
import UIKit

class FourthScreen: UIViewController {
    
    
  
    @IBOutlet var video: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        video.allowsInlineMediaPlayback = true
        // Do any additional setup after loading the view, typically from a nib.
        video.loadHTMLString("<iframe width=\"\(video.frame.width-15)\" height=\"\(video.frame.height-15)\" src=\"\("https://www.youtube.com/embed/QO-Iu9ANsTI?rel=0&amp;controls=0&amp;showinfo=0?&start=34&end=39")?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: URL(string: "https://www.youtube.com/embed/QO-Iu9ANsTI?rel=0&amp;controls=0&amp;showinfo=0?&start=34&end=39"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
 
    
}
