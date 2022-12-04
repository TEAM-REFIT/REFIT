import UIKit
import FirebaseAuth
//import GoogleSignIn

class MainClosetViewController:UIViewController {
    
    @IBOutlet weak var categoryBar: UISegmentedControl!
    @IBOutlet var allClosetCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigation bar title font setting
        self.navigationItem.title = "내 옷장"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.pretendard(size: 18, family: .SemiBold)]
        
        initCategoryBar()
        
        // CollectionView setting
        allClosetCollectionView.dataSource = self
        allClosetCollectionView.delegate = self
        
        let ClothesCellNib = UINib(nibName: String(describing: ClothesCell.self), bundle: nil)
        
        self.allClosetCollectionView.register(ClothesCellNib, forCellWithReuseIdentifier: String(describing: ClothesCell.self))
        
        self.allClosetCollectionView.collectionViewLayout = createCompostionalLayout()
    }
    
    @IBAction func CategoryBarTapped(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0:
            print("showAllClosetView()")
        case 1:
            print("showTopClosetView()")
        case 2:
            print("showPantsClosetView()")
        case 3:
            print("showOuterwearClosetView()")
        case 4:
            print("showShoesClosetView()")
        case 5:
            print("showEtcClosetView()")
        default:
            print("showAllClosetView()")
        }
    }
    
    @IBAction func addClothesBtnTapped(_ sender: Any) {
        let storyBoardName = UIStoryboard(name: "AddClosetViewController", bundle: nil)
        let addClosetViewController = storyBoardName.instantiateViewController(withIdentifier: "AddClosetViewController") as! AddClosetViewController
        self.navigationController?.pushViewController(addClosetViewController, animated: true)
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {

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
        return ClosetData.shared.allClosetData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ClothesCell.self), for: indexPath) as! ClothesCell
        
        cell.settingClothesCell = (ClosetData.shared.allClosetData[indexPath.row]["title"] as? String)!
        
        return cell
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

