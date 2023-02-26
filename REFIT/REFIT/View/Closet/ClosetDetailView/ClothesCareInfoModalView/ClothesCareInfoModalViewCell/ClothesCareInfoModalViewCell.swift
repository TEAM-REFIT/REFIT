//
//  ClothesCareInfoModalViewCell.swift
//  REFIT
//
//  Created by 김동윤 on 2023/02/24.
//

import UIKit

class ClothesCareInfoModalViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var tipLabel: UILabel!
    
    var topic = "" {
        didSet {
            imageView.image = UIImage(named: "testImg")
            titleLabel.text = "STEP 1. 물 온도 맞추기"
            contentsLabel.text = "세탁을 할 때 물의 온도를 30도 이내로 해야합니다. 40도를 넘으면 린넨은 수축될 수 있습니다."
            tipLabel.text = "로렘"
        }
    }
}

