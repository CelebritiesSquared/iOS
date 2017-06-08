//
//  TableViewCell.swift
//  CelebritiesSquared
//
//  Created by Dori Mouawad on 2/18/17.
//  Copyright © 2017 Nick Hoyt. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell{
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var celebName: UILabel!
    @IBOutlet var prizeLabel: UILabel!
    @IBOutlet var goalLabel: UILabel!
    @IBOutlet var endLabel: UILabel!
    @IBOutlet var viewButton: UIButton!
   var celebid = ""
    
    @IBOutlet var imageV: UIImageView!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // let tap = UITapGestureRecognizer(target: self, action: #selector(TableViewCell.celebNameTapped))
      //  celebName.addGestureRecognizer(tap)
    }
  /*
    func celebNameTapped(sender: UITapGestureRecognizer) {
        print("bigButtonTapped")
        FundraiserScreen.performSegue(withIdentifier: "toCelebProfile", sender: self)
    }
    */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = CGRectMake(8, 25, 70, 70)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    
}
