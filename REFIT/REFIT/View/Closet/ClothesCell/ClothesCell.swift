//
//  ClothesCell.swift
//  REFIT
//
//  Created by 김동윤 on 2022/11/28.
//

import UIKit
import Kingfisher

class ClothesCell: UICollectionViewCell {
    @IBOutlet var clothesImg: UIImageView!
    @IBOutlet var clothesBrandLabel: UILabel!
    @IBOutlet var clothesTitleLabel: UILabel!
    
    var clothesData: [String : Any] = [:] {
        didSet {
            self.clothesImg.kf.setImage(with: URL(string: clothesData["imageUrl"] as! String))
            self.clothesImg.layer.cornerRadius = 10
            
            self.clothesBrandLabel.text = clothesData["brand"] as? String
            self.clothesBrandLabel.font = UIFont.pretendard(size: 14, family: .Regular)
            
            self.clothesTitleLabel.text = clothesData["title"] as? String
            self.clothesTitleLabel.font = UIFont.pretendard(size: 18, family: .Bold)
        }
    }
    
}
