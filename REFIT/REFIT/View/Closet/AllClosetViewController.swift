import UIKit

class AllClosetViewController: UIViewController {
    
    @IBOutlet var allClosetCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("AllClosetViewController")
        
        allClosetCollectionView.delegate = self
        allClosetCollectionView.dataSource = self
        allClosetCollectionView.register(UINib(nibName: "ClothesCell", bundle: .main), forCellWithReuseIdentifier: "ClothesCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allClosetCollectionView.reloadData()
    }
}

extension AllClosetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ClosetData.shared.allClosetTitleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = allClosetCollectionView.dequeueReusableCell(withReuseIdentifier: "ClothesCell", for: indexPath) as? ClothesCell else {
            return UICollectionViewCell()
        }
        
        cell.clothesTitle.text = ClosetData.shared.allClosetTitleData[indexPath.row]
        return cell
    }
    
    
}
