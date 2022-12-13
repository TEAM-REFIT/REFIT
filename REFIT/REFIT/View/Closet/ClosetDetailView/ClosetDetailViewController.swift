//
//  ClosetDetailViewController.swift
//  REFIT
//
//  Created by 김동윤 on 2022/12/13.
//

import Foundation
import UIKit

class ClosetDetailViewController: UIViewController {
    
    @IBOutlet var ClothesImgView: UIImageView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBOutlet var segmentedControlfirstView: UIView!
    @IBOutlet var segmentedControlsecondView: UIView!
    
    
    @IBOutlet var clothesTableView: UITableView!
    
    let tableViewTitleArr = ["브랜드", "색상", "소재", "사이즈"]
    let tableViewInformationArr = ["NIKE", "검정", "폴리에스테르", "S"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tabbar hidden
        self.tabBarController?.tabBar.isHidden = true
        
        initCategoryBar()
        initSegmentedControlView()
        initNavigationBar()
        
        // init imgView
        ClothesImgView.image = UIImage(named: "dummyClothesImg2")
        
        // cell 리소스 파일 가져오기
        let clothesTableViewCell = UINib(nibName: String(describing: ClothesTableViewCell.self), bundle: nil)
        
        // cell 에 리소스 등록
        self.clothesTableView.register(clothesTableViewCell, forCellReuseIdentifier: "clothesTableViewCell")
    
        self.clothesTableView.rowHeight = UITableView.automaticDimension
        self.clothesTableView.estimatedRowHeight = 52
        self.clothesTableView.separatorInset.left = 0
        
        // 델리게이트 설정
        self.clothesTableView.delegate = self
        self.clothesTableView.dataSource = self
    }
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0:
            segmentedControlfirstView.backgroundColor = .green
            segmentedControlsecondView.backgroundColor = .white
//            clothesInformationView.alpha = 1
//            clothesWashingInformationView.alpha = 0
        case 1:
            segmentedControlfirstView.backgroundColor = .white
            segmentedControlsecondView.backgroundColor = .green
//            clothesInformationView.alpha = 0
//            clothesWashingInformationView.alpha = 1
        default:
            segmentedControlfirstView.backgroundColor = .green
            segmentedControlsecondView.backgroundColor = .white
        }
    }
    
    // MARK: - init
    /// init to cartegoryBar
    private func initCategoryBar() {
        // text size setting
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.pretendard(size: 17, family: .Medium)], for: .normal)
        
        // selected text setting
        self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, .font: UIFont.pretendard(size: 18, family: .Bold)], for: .selected)
        
        // Background color clear
        self.segmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        self.segmentedControl.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        self.segmentedControl.setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default)
        
        // Divider clear
        self.segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func initSegmentedControlView() {
        segmentedControlfirstView.backgroundColor = .green
        segmentedControlsecondView.backgroundColor = .white
    }
    
    private func initNavigationBar() {
        self.navigationItem.title = "옷 정보"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.pretendard(size: 18, family: .SemiBold)]
    }
}

extension ClosetDetailViewController: UITableViewDelegate {
    
}

extension ClosetDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = clothesTableView.dequeueReusableCell(withIdentifier: "clothesTableViewCell", for: indexPath) as! ClothesTableViewCell
        
        cell.title.text = tableViewTitleArr[indexPath.row]
        cell.information.text = tableViewInformationArr[indexPath.row]
        
        return cell
    }
}
