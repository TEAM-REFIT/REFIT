//
//  ClothesCareInfoModalViewCell.swift
//  REFIT
//
//  Created by 김동윤 on 2023/02/24.
//

import UIKit
import Kingfisher

class ClothesCareInfoModalViewCell: UICollectionViewCell {
    @IBOutlet var backGroundView: UIView!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    
    var imageUrl = "" {
        didSet {
            imageView.kf.setImage(with: URL(string: imageUrl))
        }
    }
    
    var careInfo = "" {
        didSet {
            // 기본 view 세팅
            backGroundView.clipsToBounds = true
            backGroundView.layer.cornerRadius = 10
            
            // Font 세팅
            titleLabel.font = UIFont.pretendard(size: 20, family: .Bold)
            titleLabel.textColor = UIColor.black
            
            contentsLabel.font = UIFont.pretendard(size: 18, family: .Regular)
            contentsLabel.textColor = UIColor.black
            
            contentsLabel.text = careInfo
        }
    }
    
    var stepLabel = "" {
        didSet {
            titleLabel.text = stepLabel
        }
    }
}
