import UIKit

class SettingViewController: UIViewController, UITableViewDelegate {
    
    
    @IBOutlet var settingTableView: UITableView!
    
    var settingTableViewLabelItems = ["로그아웃"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigation bar setting
        self.navigationItem.title = "MY"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.pretendard(size: 18, family: .SemiBold)]
        
        settingTableView.dataSource = self
        settingTableView.delegate = self
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTableViewLabelItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: "ResuableCell", for: indexPath)
        cell.textLabel?.text = settingTableViewLabelItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //클릭한 셀의 이벤트 처리
        do {
            try FirebaseAuthManager.auth.signOut()
            let loginVC = getVC("LoginViewController")
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            ClosetData.shared.allClosetData = []
            present(loginVC, animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
