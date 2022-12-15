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
    
    @IBOutlet var clothesFirstTableView: UITableView!
    @IBOutlet var clothesSecondTableView: UITableView!
    
    let firstTableViewTitleArr = ["브랜드", "색상", "소재", "사이즈"]
    let firstTableViewInformationArr = ["NIKE", "검정", "폴리에스테르", "S"]
    
    let secondTableViewTitleArr = ["계절", "TPO"]
    let secondTableViewInformationArr = ["봄, 여름, 가을", "데일리", "운동"]
    
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
        self.clothesFirstTableView.register(clothesTableViewCell, forCellReuseIdentifier: "clothesTableViewCell")
    
        self.clothesFirstTableView.separatorInset.left = 0
        self.clothesSecondTableView.separatorInset.left = 0
        
        // 델리게이트 설정
        self.clothesFirstTableView.delegate = self
        self.clothesFirstTableView.dataSource = self
        
        self.clothesSecondTableView.delegate = self
        self.clothesSecondTableView.dataSource = self
        
        clothesSecondTableView.isScrollEnabled = false
        clothesFirstTableView.isScrollEnabled = false

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
        if tableView == clothesFirstTableView {
            return self.firstTableViewTitleArr.count
        } else {
            return self.secondTableViewTitleArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = clothesFirstTableView.dequeueReusableCell(withIdentifier: "clothesTableViewCell", for: indexPath) as! ClothesTableViewCell
        
        if tableView == clothesFirstTableView {
            cell.title.text = firstTableViewTitleArr[indexPath.row]
            cell.information.text = firstTableViewInformationArr[indexPath.row]
        } else {
            cell.title.text = secondTableViewTitleArr[indexPath.row]
            cell.information.text = secondTableViewInformationArr[indexPath.row]
        }
        
        // 클릭 안 되게 막기
        cell.selectionStyle = .none
        return cell
    }
}
