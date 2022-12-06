//
//  ClothesCell.swift
//  REFIT
//
//  Created by 김동윤 on 2022/11/28.
//

import UIKit

class ClothesCell: UICollectionViewCell {
    @IBOutlet var clothesImg: UIImageView!
    @IBOutlet var clothesBrandLabel: UILabel!
    @IBOutlet var clothesTitleLabel: UILabel!
    
    var settingClothesCell: String = "" {
        didSet {
//            self.clothesImg.image = UIImage(systemName: settingClothesCell)
            self.clothesBrandLabel.text = "나이키"
            self.clothesTitleLabel.text = settingClothesCell
            
            self.clothesBrandLabel.font = UIFont.pretendard(size: 14, family: .Regular)
            self.clothesTitleLabel.font = UIFont.pretendard(size: 18, family: .Bold)
        }
    }
}
