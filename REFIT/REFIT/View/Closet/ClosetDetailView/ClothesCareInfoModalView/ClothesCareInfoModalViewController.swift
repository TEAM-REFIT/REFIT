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
    
    var modalTitle: String = ""
    var careImgData: [String : Any] = [ : ]
    var careStringData: [String : Any] = [ : ]
    
    private var careStringArr: [String] = []
    private var careImgArr: [String] = []
    
    // material
    let materialStep = [
        "Intro",
        "STEP.1 세탁하기",
        "STEP.2 건조하기",
        "STEP.3 다림질하기",
        "STEP.4 보관하기"
    ]
    
    let twoStep = [
        "Intro",
        "STEP.1 세탁하기",
        "STEP.2 보관하기"
    ]

    // category
    let categoryStep = [
        "Intro",
        "STEP.1 세탁하기",
        "STEP.2 건조하기",
        "STEP.3 보관하기"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleItem.title = modalTitle
        
        let collectionNib = UINib(nibName: String(describing: ClothesCareInfoModalViewCell.self), bundle: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        self.collectionView.register(collectionNib, forCellWithReuseIdentifier: String(describing: ClothesCareInfoModalViewCell.self))
        self.collectionView.collectionViewLayout = createCompostionalLayout()
        
        guard let careStringArr = careStringData[modalTitle] as? [String] else { return print("string")}
        guard let careImgArr = careImgData[modalTitle] as? [String] else { return print("img")}
        
        self.careStringArr = careStringArr
        self.careImgArr = careImgArr
    }

}

extension ClothesCareInfoModalViewController: UICollectionViewDelegate {
    
}

extension ClothesCareInfoModalViewController: UICollectionViewDataSource {
    // cell 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return careStringArr.count
    }
    
    // cell data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ClothesCareInfoModalViewCell.self), for: indexPath) as! ClothesCareInfoModalViewCell
        
        cell.careInfo = careStringArr[indexPath.row]
        cell.imageUrl = careImgArr[indexPath.row]
        
        switch careStringArr.count {
        // 소재 관리(인트로, 1, 2, 3, 4)
        case 5:
            cell.stepLabel = materialStep[indexPath.row]
            // 카테고리 관리(인트로, 1, 2, 3)
        case 4:
            cell.stepLabel = categoryStep[indexPath.row]
        case 3:
            // 2스텝 관리(인트로, 1, 2, 3)
            cell.stepLabel = twoStep[indexPath.row]
        default:
            cell.stepLabel = materialStep[indexPath.row]
        }
        
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
