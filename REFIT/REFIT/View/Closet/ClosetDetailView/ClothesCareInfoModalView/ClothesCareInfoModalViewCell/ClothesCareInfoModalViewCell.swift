//
//  ClothesCareInfoModalViewCell.swift
//  REFIT
//
//  Created by 김동윤 on 2023/02/24.
//

import UIKit

class ClothesCareInfoModalViewCell: UICollectionViewCell {
    @IBOutlet var backGroundView: UIView!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var tipLabel: UILabel!
    
    var topic = "" {
        didSet {
            // 기본 view 세팅
            backGroundView.layer.cornerRadius = 10
            imageView.roundCorners(leftTop: 10, rightTop: 10, leftBottom: 0, rightBottom: 0)
            
            // Font 세팅
            titleLabel.font = UIFont.pretendard(size: 20, family: .Bold)
            titleLabel.textColor = UIColor.black
            
            contentsLabel.font = UIFont.pretendard(size: 18, family: .Regular)
            contentsLabel.textColor = UIColor.black
            
            tipLabel.font = UIFont.pretendard(size: 14, family: .Regular)
            tipLabel.textColor = UIColor.darkGray
            
            imageView.image = UIImage(named: "testImg")
            titleLabel.text = "STEP 1. 물 온도 맞추기"
            contentsLabel.text = "세탁을 할 때 물의 온도를 30도 이내로 해야합니다. 40도를 넘으면 린넨은 수축될 수 있습니다."
            tipLabel.text = "로렘"
        }
    }
}

