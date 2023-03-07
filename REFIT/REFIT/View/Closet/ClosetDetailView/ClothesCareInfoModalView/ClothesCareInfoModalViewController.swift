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
    @IBOutlet var titleItem: UINavigationItem!
    
    var modalTitle: String = "title"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        self.titleItem.title = modalTitle
        
        let collectionNib = UINib(nibName: String(describing: ClothesCareInfoModalViewCell.self), bundle: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.register(collectionNib, forCellWithReuseIdentifier: String(describing: ClothesCareInfoModalViewCell.self))
        self.collectionView.collectionViewLayout = createCompostionalLayout()
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
    
    // UICollectionViewDelegateFlowLayout 상속
    //컬렉션뷰 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width  , height:  collectionView.frame.height)
    }
    
}

extension ClothesCareInfoModalViewController {
    fileprivate func createCompostionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)

            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

            // 가로 스크롤만 가능하도록 orthogonalScrollingBehavior 속성 설정
            section.orthogonalScrollingBehavior = .paging

            return section
        }
        return layout
    }
}
