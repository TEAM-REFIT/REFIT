import UIKit

class AllClosetViewController: UIViewController {
    
    @IBOutlet var allClosetCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AllClosetViewController")
        
        self.allClosetCollectionView.delegate = self
        self.allClosetCollectionView.dataSource = self
        
        allClosetCollectionView.reloadData()
    }

}

// cell data
extension AllClosetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("collectionView-\(ClosetData.shared.allClosetTitleData)")
        return ClosetData.shared.allClosetTitleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! allClosetCollectionViewCell
        
        cell.backgroundColor = .lightGray
        cell.titleLabel.text = ClosetData.shared.allClosetTitleData[indexPath.row]
        cell.titleLabel.backgroundColor = .yellow
        
        return cell
    }
}

// cell layout
extension AllClosetViewController: UICollectionViewDelegateFlowLayout {

    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }

    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = 120
        let height: CGFloat = 100
        
        return CGSize(width: width, height: height)
    }
}

class allClosetCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
}
