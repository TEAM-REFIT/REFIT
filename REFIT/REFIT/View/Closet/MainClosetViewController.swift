import UIKit
import FirebaseAuth
//import GoogleSignIn

class MainClosetViewController:UIViewController {
    
    @IBOutlet weak var categoryBar: UISegmentedControl!
    @IBOutlet var allClosetCollectionView: UICollectionView!
    
    var collectionViewCellData = ClosetData.shared.allClosetData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigation bar title font setting
        initNavigationBar(title: "내 옷장")
        
        initCategoryBar()
        
        // CollectionView setting
        allClosetCollectionView.dataSource = self
        allClosetCollectionView.delegate = self
        
        let ClothesCellNib = UINib(nibName: String(describing: ClothesCell.self), bundle: nil)
        
        self.allClosetCollectionView.register(ClothesCellNib, forCellWithReuseIdentifier: String(describing: ClothesCell.self))
        
        self.allClosetCollectionView.collectionViewLayout = createCompostionalLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryBar.selectedSegmentIndex = 0
        collectionViewCellData = ClosetData.shared.allClosetData
        allClosetCollectionView.reloadData()
    }
    
    @IBAction func categoryBarTapped(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0:
            collectionViewCellData = ClosetData.shared.allClosetData
        case 1:
            collectionViewCellData = ClosetData.shared.topClosetData
        case 2:
            collectionViewCellData = ClosetData.shared.pantsClosetData
        case 3:
            collectionViewCellData = ClosetData.shared.outerClosetData
        case 4:
            collectionViewCellData = ClosetData.shared.shoesClosetData
        case 5:
            collectionViewCellData = ClosetData.shared.etcClosetData
        default:
            print("showAllClosetView()")
        }
        allClosetCollectionView.reloadData()
    }
    
    @IBAction func addClothesBtnTapped(_ sender: Any) {
        let storyBoardName = UIStoryboard(name: "AddClosetViewController", bundle: nil)
        let addClosetViewController = storyBoardName.instantiateViewController(withIdentifier: "AddClosetViewController") as! AddClosetViewController
        
        self.navigationController?.pushViewController(addClosetViewController, animated: true)
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        do {
            try FirebaseAuthManager.auth.signOut()
            let loginVC = getVC("LoginViewController")
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            
            // ClosetData 데이터 삭제
            ClosetData.shared.allClosetData.removeAll()
            ClosetData.shared.topClosetData.removeAll()
            ClosetData.shared.pantsClosetData.removeAll()
            ClosetData.shared.outerClosetData.removeAll()
            ClosetData.shared.shoesClosetData.removeAll()
            ClosetData.shared.etcClosetData.removeAll()
            present(loginVC, animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    //MARK: init
    
    /// init to cartegoryBar
    private func initCategoryBar() {
        // text size setting
        self.categoryBar.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.pretendard(size: 17, family: .Medium)], for: .normal)
        
        // selected text setting
        self.categoryBar.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, .font: UIFont.pretendard(size: 18, family: .Bold)], for: .selected)
        
        // Background color clear
        self.categoryBar.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        self.categoryBar.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        self.categoryBar.setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default)
        
        // Divider clear
        self.categoryBar.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
}

extension MainClosetViewController: UICollectionViewDelegate {
    
}

extension MainClosetViewController: UICollectionViewDataSource {
    // cell 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellData.count
    }
    
    // cell data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ClothesCell.self), for: indexPath) as! ClothesCell
        cell.clothesData = collectionViewCellData[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoardName = UIStoryboard(name: "ClosetDetailViewController", bundle: nil)
        let closetDetailViewController = storyBoardName.instantiateViewController(withIdentifier: "ClosetDetailViewController") as! ClosetDetailViewController
        
        closetDetailViewController.clothesData = collectionViewCellData[indexPath.row]
        
        self.navigationController?.pushViewController(closetDetailViewController, animated: true)
    }
}

// colletion view cell layout
extension MainClosetViewController {
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
            let grouSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(187))
            
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
