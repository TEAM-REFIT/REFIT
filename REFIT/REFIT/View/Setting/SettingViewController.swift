import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var profileImgView: UIImageView!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileClothesCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar(title: "MY")

        // init profile
        initProfileImgView()
        initProfileNameLabel()
        initProfileClothesCountLabel()
    }
}

extension SettingViewController {
    /// init profile image view
    func initProfileImgView() {
        profileImgView.layer.cornerRadius = profileImgView.bounds.size.width * 0.5
        profileImgView.backgroundColor = .gray
        guard let url = FirebaseAuthManager.userProfileImg else { return }
        profileImgView.load(url: url)
    }
    
    ///init profile name label
    func initProfileNameLabel() {
        profileNameLabel.text = FirebaseAuthManager.userName
        profileNameLabel.font = UIFont.pretendard(size: 20, family: .Bold)
    }
    
    /// init profile clothes count label
    func initProfileClothesCountLabel() {
        profileClothesCountLabel.text = "등록된 옷 \(ClosetData.shared.allClosetData.count)벌"
        profileClothesCountLabel.font = UIFont.pretendard(size: 18, family: .Medium)
    }
}
