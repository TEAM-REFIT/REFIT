import UIKit

class AllClosetViewController: UIViewController {
    
    @IBOutlet var allClosetCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allClosetCollectionView.delegate = self
        allClosetCollectionView.dataSource = self
        allClosetCollectionView.register(UINib(nibName: "ClothesCell", bundle: .main), forCellWithReuseIdentifier: "ClothesCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // addClosetView 에서 나올 때 콜렉션뷰 리로드
        allClosetCollectionView.reloadData()
    }
}

extension AllClosetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ClosetData.shared.allClosetData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = allClosetCollectionView.dequeueReusableCell(withReuseIdentifier: "ClothesCell", for: indexPath) as? ClothesCell else {
            return UICollectionViewCell()
        }
        
        cell.clothesTitle.text = ClosetData.shared.allClosetData[indexPath.row]["title"] as? String
        return cell
    }
}
