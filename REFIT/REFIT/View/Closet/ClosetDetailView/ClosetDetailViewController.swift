//
//  ClosetDetailViewController.swift
//  REFIT
//
//  Created by 김동윤 on 2022/12/13.
//

import Foundation
import UIKit

class ClosetDetailViewController: UIViewController {
    // All view
    @IBOutlet var viewRadius: [UIView]!
    
    // Title view
    @IBOutlet var titleViewCategoryLabel: UILabel!
    @IBOutlet var titleViewTitleLabl: UILabel!
    @IBOutlet var titleViewArrowIcon: UIImageView!
    @IBOutlet var titleViewClothesImgView: UIImageView!
    
    
    // ClothesInfoView
    @IBOutlet var clothesInfoViewHeaderLabel: UILabel!
    @IBOutlet var clothesInfoViewTableView: UITableView!
    
    // WearInfoView
    @IBOutlet var wearInfoViewHeaderLabel: UILabel!
    @IBOutlet var wearInfoViewTableView: UITableView!
    
    // CategoryCareView
    @IBOutlet var categoryCareViewHeaderLabel: UILabel!
    @IBOutlet var categoryCareViewTableView: UITableView!
    
    // MaterialCareView
    @IBOutlet var materialCareViewHeaderLabel: UILabel!
    @IBOutlet var materialCareViewTableView: UITableView!
    
    // ClothesInfoView TableView data
    let clothesInfoViewTableViewTitleArr = ["브랜드", "색상", "소재", "사이즈"]
    let clothesInfoViewTableViewInfoArr = ["NIKE", "검정", "폴리에스테르", "S"]
    
    // WearInfoView TalbeView data
    let wearInfoViewTableViewTitleArr = ["계절", "TPO"]
    let wearInfoViewTableViewInfoArr = ["봄, 여름, 가을", "데일리", "운동"]
    
    // CategoryCareView TableView data
    let categoryCareViewTableViewTitleArr = ["상의 세탁 방법", "상의 관리 방법"]
    
    // MaterialCareView TableView data
    let materialCareViewTableViewTitleArr = ["폴리에스테르 세탁 방법", "면 세탁 방법", "폴리에스테르 세탁 방법", "면 세탁 방법"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NavigationBar
        initNavigationBar(title: "옷 정보")
        
        // AllViewCornerRadius
        initViewCornerRadius()
        
        // init View
        initTitleView()
        initclothesInfoView()
        initWearInfoView()
        initCategoryCareView()
        initMaterialCareView()
        
        // TableView
        tableViewDelegate()
        cellRegister()
        initTableView()

    }
}

//MARK: init
extension ClosetDetailViewController {
    // All view
    /// View cornerRadius
    func initViewCornerRadius() {
        for i in viewRadius {
            i.layer.cornerRadius = 10
            i.layer.masksToBounds = true
        }
    }
    
    // Title view
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
    
    // ClothesInfoView
    /// initclothesInformationView
    func initclothesInfoView() {
        // Label
        clothesInfoViewHeaderLabel.text = "옷 정보"
        clothesInfoViewHeaderLabel.font = UIFont.pretendard(size: 20, family: .Bold)
        
    }
    
    // WearInfoView
    /// initWearInformationView
    func initWearInfoView() {
        // Label
        wearInfoViewHeaderLabel.text = "착용 정보"
        wearInfoViewHeaderLabel.font = UIFont.pretendard(size: 20, family: .Bold)
    }
    
    func initCategoryCareView() {
        categoryCareViewHeaderLabel.text = "카테고리별 관리"
        categoryCareViewHeaderLabel.font = UIFont.pretendard(size: 20, family: .Bold)
    }
    
    func initMaterialCareView() {
        materialCareViewHeaderLabel.text = "소재별 관리"
        materialCareViewHeaderLabel.font = UIFont.pretendard(size: 20, family: .Bold)
        
        materialCareViewTableView.translatesAutoresizingMaskIntoConstraints = false
        materialCareViewTableView.heightAnchor.constraint(equalToConstant: CGFloat(materialCareViewTableViewTitleArr.count * 52 - 1)).isActive = true
    }
}

// MARK: TableView
extension ClosetDetailViewController {
    func tableViewDelegate() {
        // clothesInfoViewTableView
        self.clothesInfoViewTableView.delegate = self
        self.clothesInfoViewTableView.dataSource = self
        
        // wearInfoViewTableView
        self.wearInfoViewTableView.delegate = self
        self.wearInfoViewTableView.dataSource = self
        
        // categoryCareViewTableView
        self.categoryCareViewTableView.delegate = self
        self.categoryCareViewTableView.dataSource = self
        
        // materialCareViewTableView
        self.materialCareViewTableView.delegate = self
        self.materialCareViewTableView.dataSource = self
    }
    
    func cellRegister() {
        // cell 리소스 파일 가져오기
        let clothesInfoTableViewCell = UINib(nibName: String(describing: ClothesInfoTableViewCell.self), bundle: nil)
        let clothesCareTableViewCell = UINib(nibName: String(describing: ClothesCareTableViewCell.self), bundle: nil)
        
        // cell 에 리소스 등록
        self.clothesInfoViewTableView.register(clothesInfoTableViewCell, forCellReuseIdentifier: "ClothesInfoTableViewCell")
        self.categoryCareViewTableView.register(clothesCareTableViewCell, forCellReuseIdentifier: "ClothesCareTableViewCell")
        self.materialCareViewTableView.register(clothesCareTableViewCell, forCellReuseIdentifier: "ClothesCareTableViewCell")
    }
    
    func initTableView() {
        // 왼쪽 밑줄 마진값 설정
        self.clothesInfoViewTableView.separatorInset.left = 0
        self.wearInfoViewTableView.separatorInset.left = 0
        self.categoryCareViewTableView.separatorInset.left = 0
        self.materialCareViewTableView.separatorInset.left = 0
        
        // 스크롤 막기
        clothesInfoViewTableView.isScrollEnabled = false
        wearInfoViewTableView.isScrollEnabled = false
        categoryCareViewTableView.isScrollEnabled = false
        materialCareViewTableView.isScrollEnabled = false
    }
}

extension ClosetDetailViewController: UITableViewDelegate {
    // cell 의 height 값 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

extension ClosetDetailViewController: UITableViewDataSource {
    // cell 의 개수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // tableView 종류대로 개수 설정
        switch tableView {
        case clothesInfoViewTableView:
            return clothesInfoViewTableViewTitleArr.count
        case wearInfoViewTableView:
            return wearInfoViewTableViewTitleArr.count
        case categoryCareViewTableView:
            return 2
        case materialCareViewTableView:
            return materialCareViewTableViewTitleArr.count
        default:
            return 0
        }
    }
    
    // cell 데이터, 스타일 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // tableView 종류대로 데이터, 스타일 설정
        switch tableView {
        case clothesInfoViewTableView:
            return initClothesInfoCell(titleArr: clothesInfoViewTableViewTitleArr, infoArr: clothesInfoViewTableViewInfoArr)
        case wearInfoViewTableView:
            return initClothesInfoCell(titleArr: wearInfoViewTableViewTitleArr, infoArr: wearInfoViewTableViewInfoArr)
        case categoryCareViewTableView:
            return initCategoryCareCell(titleArr: categoryCareViewTableViewTitleArr, view: categoryCareViewTableView)
        case materialCareViewTableView:
            return initCategoryCareCell(titleArr: materialCareViewTableViewTitleArr, view: materialCareViewTableView)
        default:
            let clothesInfoCell = clothesInfoViewTableView.dequeueReusableCell(withIdentifier: "ClothesInfoTableViewCell", for: indexPath) as! ClothesInfoTableViewCell
            return clothesInfoCell
        }
        
        // ClothesInfoCell 을 init 하는 함수
        func initClothesInfoCell(titleArr: [String], infoArr: [String]) -> UITableViewCell {
            let clothesInfoCell = clothesInfoViewTableView.dequeueReusableCell(withIdentifier: "ClothesInfoTableViewCell", for: indexPath) as! ClothesInfoTableViewCell
            
            clothesInfoCell.selectionStyle = .none
            
            clothesInfoCell.title.font = UIFont.pretendard(size: 20, family: .Medium)
            clothesInfoCell.information.font = UIFont.pretendard(size: 18, family: .Medium)
            clothesInfoCell.information.textColor = .gray
            
            // text
            clothesInfoCell.title.text = titleArr[indexPath.row]
            clothesInfoCell.information.text = infoArr[indexPath.row]
            
            return clothesInfoCell
        }
        
        // CategoryCareCell 을 init 하는 함수
        func initCategoryCareCell(titleArr: [String], view: UITableView) -> UITableViewCell {
            let categoryCareCell = view.dequeueReusableCell(withIdentifier: "ClothesCareTableViewCell", for: indexPath) as! ClothesCareTableViewCell
            // CategoryCareCell
            categoryCareCell.title.font = UIFont.pretendard(size: 20, family: .Medium)
            categoryCareCell.Icon.image = UIImage(named: "chevronRightIcon")
            categoryCareCell.title.text = titleArr[indexPath.row]
            return categoryCareCell
        }
    }
    
    // tableViewCell 클릭 이벤트 설정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case categoryCareViewTableView:
            print(categoryCareViewTableViewTitleArr[indexPath.row])
            let storyBoardName = UIStoryboard(name: "ClothesCareInfoModalViewController", bundle: nil)
            let closetDetailViewController = storyBoardName.instantiateViewController(withIdentifier: "ClothesCareInfoModalViewController") as! ClothesCareInfoModalViewController
            self.present(closetDetailViewController, animated: true)
        case materialCareViewTableView:
            print(materialCareViewTableViewTitleArr[indexPath.row])
        default: break
        }
    }
}
