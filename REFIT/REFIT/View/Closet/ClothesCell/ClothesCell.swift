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
    
    var settingClothesCellImg: String = "" {
        didSet {
            self.clothesImg.kf.setImage(with: URL(string: settingClothesCellImg))
        }
    }
    
    var settingClothesCellBrand: String = "" {
        didSet {
            // self.clothesImg.image = UIImage(systemName: settingClothesCell)
            self.clothesBrandLabel.text = settingClothesCellBrand
            
            self.clothesBrandLabel.font = UIFont.pretendard(size: 14, family: .Regular)
        }
    }
    
    var settingClothesCellTitle: String = "" {
        didSet {
            // self.clothesImg.image = UIImage(systemName: settingClothesCell)
            self.clothesTitleLabel.text = settingClothesCellTitle
            
            self.clothesTitleLabel.font = UIFont.pretendard(size: 18, family: .Bold)
        }
    }
}
