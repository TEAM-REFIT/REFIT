import UIKit

class ClosetMainViewController:UIViewController {
    
    @IBOutlet weak var categoryBar: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCategoryBar()
    }
    
    @IBAction func serchBtnTapped(_ sender: Any) {
        print("아직 안 되지롱")
        label.text = "아직 안 되지롱😝"
    }
    
    
    /// init to cartegoryBar
    func initCategoryBar() {
        // text size setting
        self.categoryBar.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], for: .normal)
        
        // selected text setting
        self.categoryBar.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 18, weight: .heavy)], for: .selected)
        
        // Background color clear
        self.categoryBar.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        self.categoryBar.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        self.categoryBar.setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default)
        
        // Divider clear
        self.categoryBar.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
}
