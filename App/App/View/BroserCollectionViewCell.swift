//
//  BroserCollectionViewCell.swift
//  App
//
//  Created by laijihua on 16/2/24.
//  Copyright © 2016年 laijihua. All rights reserved.
//

import UIKit
class BroserCollectionViewCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
//    var model: ArgoUser?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.shadowColor = UIColor.blackColor().CGColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bgView.layer.shadowOpacity = 0.4
        bgView.layer.shadowRadius = 5
        
        nameLbl.layer.shadowColor = UIColor.blackColor().CGColor
        nameLbl.layer.shadowOffset = CGSizeZero
        nameLbl.layer.shadowOpacity = 0.2
        nameLbl.layer.shadowRadius = 3
        
        descLbl.layer.cornerRadius = 10
        descLbl.layer.shadowOffset = CGSizeZero
        descLbl.layer.shadowColor = UIColor.blackColor().CGColor
        descLbl.layer.shadowOpacity = 0.2
        descLbl.layer.shadowRadius = 3
        
    }
    
//    func bindModel(model: ArgoUser) {
//        self.model = model
//        nameLbl.text = model.full_name
//        descLbl.text = model.description
//    }
    
}
