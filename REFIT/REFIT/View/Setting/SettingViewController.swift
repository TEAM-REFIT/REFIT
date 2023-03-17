import UIKit

class SettingViewController: UIViewController {
    
    
    @IBOutlet var viewCornerRadius: [UIView]!
    
    @IBOutlet var lineView: UIView!
    
    @IBOutlet var logoImgView: UIImageView!
    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var loginLabel: UILabel!
    
    @IBOutlet var idInfoLabel: UILabel!
    @IBOutlet var loginInfoLabel: UILabel!
    
    @IBOutlet var accountManagementLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = .white
        initNavigationBar(title: "MY")
        
        viewCornerRadiusSetting()
        initLineView()
        
        initLabel()
        
        initLogoImgView()
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
        lineView.backgroundColor = UIColor.lightGray
    }
    
    /// label setting
    func initLabel() {
        let userId = (FirebaseAuthManager.userID).substring(from: 0, to: 5)
        guard let loginInfo = UserDefaults.standard.string(forKey: "loginInfo") else { return }
        
        LabelSetting(label: idLabel, text: "ID", color: .black)
        LabelSetting(label: idInfoLabel, text: userId, color: .gray)
        
        LabelSetting(label: loginLabel, text: "로그인 정보", color: .black)
        LabelSetting(label: loginInfoLabel, text: loginInfo, color: .gray)
        
        
        LabelSetting(label: accountManagementLabel, text: "계정 관리", color: .black)
        
        func LabelSetting(label: UILabel, text: String, color: UIColor) {
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
}
