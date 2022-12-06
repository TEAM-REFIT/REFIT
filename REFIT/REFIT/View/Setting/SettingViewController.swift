import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var profileImgView: UIImageView!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileClothesCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar(title: "MY")
        profileImgView.layer.cornerRadius = profileImgView.bounds.size.width * 0.5
        
        guard let url = FirebaseAuthManager.userProfileImg else { return }
        profileImgView.load(url: url)
        
        profileImgView.backgroundColor = .gray
        
        
        profileNameLabel.text = FirebaseAuthManager.userName
        profileClothesCountLabel.text = "등록된 옷 \(ClosetData.shared.allClosetData.count)벌"
        profileNameLabel.font = UIFont.pretendard(size: 20, family: .Bold)
        profileClothesCountLabel.font = UIFont.pretendard(size: 18, family: .Medium)
    }
}
