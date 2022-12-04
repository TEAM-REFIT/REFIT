import UIKit

class AllClosetViewController: UIViewController {
    
    @IBOutlet var allClosetCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allClosetCollectionView.dataSource = self
        allClosetCollectionView.delegate = self
        
        let ClothesCellNib = UINib(nibName: String(describing: ClothesCell.self), bundle: nil)
        
        self.allClosetCollectionView.register(ClothesCellNib, forCellWithReuseIdentifier: String(describing: ClothesCell.self))
        
        self.allClosetCollectionView.collectionViewLayout = createCompostionalLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // addClosetView 에서 나올 때 콜렉션뷰 리로드
        allClosetCollectionView.reloadData()
    }
}

extension AllClosetViewController: UICollectionViewDelegate {
    
}

extension AllClosetViewController: UICollectionViewDataSource {
    
    // cell 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ClosetData.shared.allClosetData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ClothesCell.self), for: indexPath) as! ClothesCell
        
        cell.settingClothesCell = (ClosetData.shared.allClosetData[indexPath.row]["title"] as? String)!
        
        return cell
    }
}

extension AllClosetViewController {
    fileprivate func createCompostionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            // 만들게 되면 튜플 (키: 값, 키: 값) 의 묶음으로 들어옴 반환 하는 것은 NSCollectionLayoutSection 콜렉션 레이아웃 섹션을 반환해야함
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 아이템에 대한 사이즈 - absolute 는 고정값, estimated 는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            // 위에서 만든 아이템 사이즈로 아이템 만들기
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            // 그룹사이즈
            let grouSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(182))
            
            // 변경할 부분
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitem: item, count: 3)
            
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
            
            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            return section
        }
        return layout
    }
}

