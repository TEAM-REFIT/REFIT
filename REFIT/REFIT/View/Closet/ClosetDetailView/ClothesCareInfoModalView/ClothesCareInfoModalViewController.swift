//
//  ClothesCareInfoModalViewController.swift
//  REFIT
//
//  Created by 김동윤 on 2022/12/20.
//

import Foundation
import UIKit

class ClothesCareInfoModalViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        
        let collectionNib = UINib(nibName: String(describing: ClothesCareInfoModalViewCell.self), bundle: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.register(collectionNib, forCellWithReuseIdentifier: String(describing: ClothesCareInfoModalViewCell.self))
    }

}

extension ClothesCareInfoModalViewController: UICollectionViewDelegate {
    
}

extension ClothesCareInfoModalViewController: UICollectionViewDataSource {
    // cell 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // cell data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ClothesCareInfoModalViewCell.self), for: indexPath) as! ClothesCareInfoModalViewCell
        
        cell.topic = "test"
        
        return cell
    }
    
    
}

//extension ClothesCareInfoModalViewController {
//    fileprivate func createCompostionalLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout {
//            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//            item.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 100, bottom: 100, trailing: 100)
//
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//
//            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
//
//            // 그룹으로 섹션 만들기
//            let section = NSCollectionLayoutSection(group: group)
//
//            // 섹션에 대한 간격 설정
//            section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 100, bottom: 100, trailing: 100)
//
//            return section
//        }
//        return layout
//    }
//}
