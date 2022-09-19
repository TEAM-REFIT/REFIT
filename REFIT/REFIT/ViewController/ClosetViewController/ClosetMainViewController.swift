import UIKit

class ClosetMainViewController:UIViewController {
    
    @IBOutlet weak var categoryBar: UISegmentedControl!
    
    @IBOutlet weak var allClosetView: UIView!
    @IBOutlet weak var topClosetView: UIView!
    @IBOutlet weak var pantsClosetView: UIView!
    @IBOutlet weak var outerwearClosetView: UIView!
    @IBOutlet weak var shoesClosetView: UIView!
    @IBOutlet weak var etcClosetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCategoryBar()
        initContainerView()
    }
    
    @IBAction func CategoryBarTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            showAllClosetView()
        } else if sender.selectedSegmentIndex == 1 {
            showTopClosetView()
        } else if sender.selectedSegmentIndex == 2 {
            showPantsClosetView()
        } else if sender.selectedSegmentIndex == 3 {
            showOuterwearClosetView()
        } else if sender.selectedSegmentIndex == 4 {
            showShoesClosetView()
        } else if sender.selectedSegmentIndex == 5 {
            showEtcClosetView()
        }
    }
    
    func showAllClosetView() {
        allClosetView.alpha = 1.0
        topClosetView.alpha = 0.0
        pantsClosetView.alpha = 0.0
        outerwearClosetView.alpha = 0.0
        shoesClosetView.alpha = 0.0
        etcClosetView.alpha = 0.0
    }
    
    func showTopClosetView() {
        allClosetView.alpha = 0.0
        topClosetView.alpha = 1.0
        pantsClosetView.alpha = 0.0
        outerwearClosetView.alpha = 0.0
        shoesClosetView.alpha = 0.0
        etcClosetView.alpha = 0.0
    }
    
    func showPantsClosetView() {
        allClosetView.alpha = 0.0
        topClosetView.alpha = 0.0
        pantsClosetView.alpha = 1.0
        outerwearClosetView.alpha = 0.0
        shoesClosetView.alpha = 0.0
        etcClosetView.alpha = 0.0
    }
    
    func showOuterwearClosetView() {
        allClosetView.alpha = 0.0
        topClosetView.alpha = 0.0
        pantsClosetView.alpha = 0.0
        outerwearClosetView.alpha = 1.0
        shoesClosetView.alpha = 0.0
        etcClosetView.alpha = 0.0
    }
    
    func showShoesClosetView() {
        allClosetView.alpha = 0.0
        topClosetView.alpha = 0.0
        pantsClosetView.alpha = 0.0
        outerwearClosetView.alpha = 0.0
        shoesClosetView.alpha = 1.0
        etcClosetView.alpha = 0.0
    }
    
    func showEtcClosetView() {
        allClosetView.alpha = 0.0
        topClosetView.alpha = 0.0
        pantsClosetView.alpha = 0.0
        outerwearClosetView.alpha = 0.0
        shoesClosetView.alpha = 0.0
        etcClosetView.alpha = 1.0
    }
    
    //MARK: init
    
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
    
    /// init to containerView
    func initContainerView() {
        allClosetView.alpha = 1.0
        topClosetView.alpha = 0.0
        pantsClosetView.alpha = 0.0
        outerwearClosetView.alpha = 0.0
        shoesClosetView.alpha = 0.0
        etcClosetView.alpha = 0.0
    }
    
}
