//
//  ClosetDetailViewController.swift
//  REFIT
//
//  Created by 김동윤 on 2022/12/13.
//

import Foundation
import UIKit

class ClosetDetailViewController: UIViewController {
    // all view
    @IBOutlet var viewRadius: [UIView]!
    
    // title view
    @IBOutlet var titleViewCategoryLabel: UILabel!
    @IBOutlet var titleViewTitleLabl: UILabel!
    @IBOutlet var titleViewArrowIcon: UIImageView!
    @IBOutlet var titleViewClothesImgView: UIImageView!
    
    // clothesInformationView
    @IBOutlet var clothesInformationViewHeaderLabel: UILabel!
    @IBOutlet var clothesInformationViewTableView: UITableView!
    
    // WearInformationView
    @IBOutlet var wearInformationViewHeaderLabel: UILabel!
    @IBOutlet var wearInformationViewTableView: UITableView!
    
    let clothesInformationViewTableViewTitleArr = ["브랜드", "색상", "소재", "사이즈"]
    let clothesInformationViewTableViewInformationArr = ["NIKE", "검정", "폴리에스테르", "S"]
    
    let wearInformationViewTableViewTitleArr = ["계절", "TPO"]
    let wearInformationViewTableViewInformationArr = ["봄, 여름, 가을", "데일리", "운동"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewRadius()
        
        initTitleView()
        initclothesInformationView()
        initWearInformationView()
        
        // table view
        tableViewDelegate()
        cellRegister()
        initTableView()

    }
}

//MARK: init
extension ClosetDetailViewController {
    // all view
    /// view radius
    func initViewRadius() {
        for i in viewRadius {
            i.layer.cornerRadius = 10
            i.layer.masksToBounds = true
        }
    }
    
    // title view
    /// init title view
    func initTitleView() {
        // Label
        titleViewCategoryLabel.text = "상의"
        titleViewTitleLabl.text = "나이키 스우시 반팔티"
        titleViewCategoryLabel.font = UIFont.pretendard(size: 20, family: .Bold)
        titleViewTitleLabl.font = UIFont.pretendard(size: 20, family: .Bold)
        
        // Image
        titleViewArrowIcon.image = UIImage(named: "chevronRightIcon")
        titleViewClothesImgView.image = UIImage(named: "dummyClothesImg2")
    }
    
    // clothesInformationView
    /// initclothesInformationView
    func initclothesInformationView() {
        // Label
        clothesInformationViewHeaderLabel.text = "옷 정보"
        clothesInformationViewHeaderLabel.font = UIFont.pretendard(size: 20, family: .Bold)
        
    }
    
    // wearInformationView
    /// initWearInformationView
    func initWearInformationView() {
        // Label
        wearInformationViewHeaderLabel.text = "착용 정보"
        wearInformationViewHeaderLabel.font = UIFont.pretendard(size: 20, family: .Bold)
    }
}

// MARK: TableView
extension ClosetDetailViewController {
    func tableViewDelegate() {
        self.clothesInformationViewTableView.delegate = self
        self.clothesInformationViewTableView.dataSource = self
        
        self.wearInformationViewTableView.delegate = self
        self.wearInformationViewTableView.dataSource = self
    }
    
    func cellRegister() {
        // cell 리소스 파일 가져오기
        let clothesTableViewCell = UINib(nibName: String(describing: ClothesTableViewCell.self), bundle: nil)
        
        // cell 에 리소스 등록
        self.clothesInformationViewTableView.register(clothesTableViewCell, forCellReuseIdentifier: "clothesTableViewCell")
    }
    
    func initTableView() {
        // 왼쪽 밑줄 마진값 설정
        self.clothesInformationViewTableView.separatorInset.left = 0
        self.wearInformationViewTableView.separatorInset.left = 0
        
        // 스크롤 막기
        clothesInformationViewTableView.isScrollEnabled = false
        wearInformationViewTableView.isScrollEnabled = false
    }
}

extension ClosetDetailViewController: UITableViewDelegate {

}

extension ClosetDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case clothesInformationViewTableView:
            return clothesInformationViewTableViewTitleArr.count
        case wearInformationViewTableView:
            return wearInformationViewTableViewTitleArr.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = clothesInformationViewTableView.dequeueReusableCell(withIdentifier: "clothesTableViewCell", for: indexPath) as! ClothesTableViewCell
        // 전체 세팅
        // cell setting
        cell.selectionStyle = .none
        // label setting
        cell.title.font = UIFont.pretendard(size: 20, family: .Medium)
        cell.information.font = UIFont.pretendard(size: 18, family: .Regular)
        cell.information.textColor = .gray
        
        switch tableView {
        case clothesInformationViewTableView:
            cell.title.text = clothesInformationViewTableViewTitleArr[indexPath.row]
            cell.information.text = clothesInformationViewTableViewInformationArr[indexPath.row]
            return cell
        case wearInformationViewTableView:
            cell.title.text = wearInformationViewTableViewTitleArr[indexPath.row]
            cell.information.text = wearInformationViewTableViewInformationArr[indexPath.row]
            return cell
        default:
            return cell
        }
    }
}
