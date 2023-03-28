import UIKit

class SettingViewController: UIViewController {
    
    
    @IBOutlet var viewCornerRadius: [UIView]!
    
    @IBOutlet var lineViews: [UIView]!
    
    @IBOutlet var logoImgView: UIImageView!
    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var loginLabel: UILabel!
    
    @IBOutlet var idInfoLabel: UILabel!
    @IBOutlet var loginInfoLabel: UILabel!
    
    // 의류 등록 벌수
    @IBOutlet var allClothesCountLabel: UILabel!
    @IBOutlet var allClothesLabel: UILabel!
    
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var topCountLabel: UILabel!
    
    @IBOutlet var pantsLabel: UILabel!
    @IBOutlet var pantsCountLabel: UILabel!
    
    @IBOutlet var outerLabel: UILabel!
    @IBOutlet var outerCountLabel: UILabel!
    
    @IBOutlet var etcLabel: UILabel!
    @IBOutlet var etcCountLabel: UILabel!
    
    @IBOutlet var accountManagementLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = .white
        initNavigationBar(title: "MY")
        
        viewCornerRadiusSetting()
        initLineView()
        
        initUserInfoLabel()
        
        initLogoImgView()
        
        initClothesCountLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clothesCount()
    }
    
    @IBAction func accountManagementBtnTapped(_ sender: Any) {
        let storyBoardName = UIStoryboard(name: "AccountManagementViewController", bundle: nil)
        let accountManagementViewController = storyBoardName.instantiateViewController(withIdentifier: "AccountManagementViewController") as! AccountManagementViewController
        
        self.navigationController?.pushViewController(accountManagementViewController, animated: true)
    }
}

extension SettingViewController {
    /// view conrner radius setting
    func viewCornerRadiusSetting() {
        for i in viewCornerRadius {
            i.layer.cornerRadius = 10
        }
    }
    
    /// line setting
    func initLineView() {
        for i in lineViews {
            i.backgroundColor = UIColor.lightGray
        }
    }
    
    /// label setting
    func initUserInfoLabel() {
        let userId = (FirebaseAuthManager.userID).substring(from: 0, to: 5)
        guard let loginInfo = UserDefaults.standard.string(forKey: "loginInfo") else { return }
        
        labelSetting(label: idLabel, text: "ID", color: .black)
        labelSetting(label: idInfoLabel, text: userId, color: .gray)
        
        labelSetting(label: loginLabel, text: "로그인 정보", color: .black)
        labelSetting(label: loginInfoLabel, text: loginInfo, color: .gray)
        
        
        labelSetting(label: accountManagementLabel, text: "계정 관리", color: .black)
        
        func labelSetting(label: UILabel, text: String, color: UIColor) {
            label.text = text
            label.font = UIFont.pretendard(size: 18, family: .Regular)
            label.textColor = color
        }
    }
    
    func initLogoImgView() {
        if UserDefaults.standard.string(forKey: "loginInfo") == "Google" {
            logoImgView.image = UIImage(named: "googleLogoIcon")
        } else if UserDefaults.standard.string(forKey: "loginInfo") == "Apple"  {
            logoImgView.image = UIImage(named: "appleLogoIcon")
        } else {
            logoImgView.image = UIImage(named: "")
        }
    }
    
    func initClothesCountLabel() {
        allClothesCountLabel.text = "0"
        allClothesCountLabel.font = UIFont.pretendard(size: 22, family: .Bold)
        
        allClothesLabel.text = "벌의 옷을 등록했어요!"
        allClothesLabel.font = UIFont.pretendard(size: 22, family: .Bold)
        
        labelSetting(label: topLabel, text: "상의")
        labelSetting(label: pantsLabel, text: "하의")
        labelSetting(label: outerLabel, text: "아우터")
        labelSetting(label: etcLabel, text: "그 외")
        
        countLabelSetting(label: topCountLabel, text: "0")
        countLabelSetting(label: pantsCountLabel, text: "0")
        countLabelSetting(label: outerCountLabel, text: "0")
        countLabelSetting(label: etcCountLabel, text: "0")
        
        func labelSetting(label: UILabel, text: String) {
            label.text = text
            label.font = UIFont.pretendard(size: 10, family: .Medium)
        }
        
        func countLabelSetting(label: UILabel, text: String) {
            label.text = text
            label.font = UIFont.pretendard(size: 18, family: .Bold)
        }
    }
    
    func clothesCount() {
        allClothesCountLabel.text = "\(ClosetData.shared.allClosetData.count)"
        topCountLabel.text = "\(ClosetData.shared.topClosetData.count)"
        pantsCountLabel.text = "\(ClosetData.shared.pantsClosetData.count)"
        outerCountLabel.text = "\(ClosetData.shared.outerClosetData.count)"
        etcCountLabel.text = "\(ClosetData.shared.etcClosetData.count + ClosetData.shared.shoesClosetData.count)"
    }
}
