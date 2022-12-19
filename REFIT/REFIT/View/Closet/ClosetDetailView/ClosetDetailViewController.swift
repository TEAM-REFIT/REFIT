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
    @IBOutlet var clothesInfoViewHeaderLabel: UILabel!
    @IBOutlet var clothesInfoViewTableView: UITableView!
    
    // WearInformationView
    @IBOutlet var wearInfoViewHeaderLabel: UILabel!
    @IBOutlet var wearInfoViewTableView: UITableView!
    
    let clothesInfoViewTableViewTitleArr = ["브랜드", "색상", "소재", "사이즈"]
    let clothesInfoViewTableViewInfoArr = ["NIKE", "검정", "폴리에스테르", "S"]
    
    let wearInfoViewTableViewTitleArr = ["계절", "TPO"]
    let wearInfoViewTableViewInfoArr = ["봄, 여름, 가을", "데일리", "운동"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewCornerRadius()
        
        initTitleView()
        initclothesInfoView()
        initWearInfoView()
        
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
    func initViewCornerRadius() {
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
    func initclothesInfoView() {
        // Label
        clothesInfoViewHeaderLabel.text = "옷 정보"
        clothesInfoViewHeaderLabel.font = UIFont.pretendard(size: 20, family: .Bold)
        
    }
    
    // wearInformationView
    /// initWearInformationView
    func initWearInfoView() {
        // Label
        wearInfoViewHeaderLabel.text = "착용 정보"
        wearInfoViewHeaderLabel.font = UIFont.pretendard(size: 20, family: .Bold)
    }
}

// MARK: TableView
extension ClosetDetailViewController {
    func tableViewDelegate() {
        self.clothesInfoViewTableView.delegate = self
        self.clothesInfoViewTableView.dataSource = self
        
        self.wearInfoViewTableView.delegate = self
        self.wearInfoViewTableView.dataSource = self
    }
    
    func cellRegister() {
        // cell 리소스 파일 가져오기
        let clothesTableViewCell = UINib(nibName: String(describing: ClothesTableViewCell.self), bundle: nil)
        
        // cell 에 리소스 등록
        self.clothesInfoViewTableView.register(clothesTableViewCell, forCellReuseIdentifier: "clothesTableViewCell")
    }
    
    func initTableView() {
        // 왼쪽 밑줄 마진값 설정
        self.clothesInfoViewTableView.separatorInset.left = 0
        self.wearInfoViewTableView.separatorInset.left = 0
        
        // 스크롤 막기
        clothesInfoViewTableView.isScrollEnabled = false
        wearInfoViewTableView.isScrollEnabled = false
    }
}

extension ClosetDetailViewController: UITableViewDelegate {

}

extension ClosetDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case clothesInfoViewTableView:
            return clothesInfoViewTableViewTitleArr.count
        case wearInfoViewTableView:
            return wearInfoViewTableViewTitleArr.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = clothesInfoViewTableView.dequeueReusableCell(withIdentifier: "clothesTableViewCell", for: indexPath) as! ClothesTableViewCell
        // 전체 세팅
        // cell setting
        cell.selectionStyle = .none
        // label setting
        cell.title.font = UIFont.pretendard(size: 20, family: .Medium)
        cell.information.font = UIFont.pretendard(size: 18, family: .Regular)
        cell.information.textColor = .gray
        
        switch tableView {
        case clothesInfoViewTableView:
            cell.title.text = clothesInfoViewTableViewTitleArr[indexPath.row]
            cell.information.text = clothesInfoViewTableViewInfoArr[indexPath.row]
            return cell
        case wearInfoViewTableView:
            cell.title.text = wearInfoViewTableViewTitleArr[indexPath.row]
            cell.information.text = wearInfoViewTableViewInfoArr[indexPath.row]
            return cell
        default:
            return cell
        }
    }
}
