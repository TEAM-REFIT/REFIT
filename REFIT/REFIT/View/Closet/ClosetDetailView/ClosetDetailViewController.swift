//
//  ClosetDetailViewController.swift
//  REFIT
//
//  Created by 김동윤 on 2022/12/13.
//

import Foundation
import UIKit
import Kingfisher
import FirebaseStorage

class ClosetDetailViewController: UIViewController {
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(buttonPressed(_:)))
        return button
    }()
    
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
    
    // ClothesData
    var clothesData: [String : Any] = [ : ]
    var materialCareData: [String : Any] = [ : ]
    var categoryCareData: [String : Any] = [ : ]
    
    // ClothesInfoView TableView data
    let clothesInfoViewTableViewTitleArr = ["친밀도", "브랜드", "색상", "소재", "사이즈"]
    var clothesInfoViewTableViewInfoArr: [String] = []
    
    // WearInfoView TalbeView data
    let wearInfoViewTableViewTitleArr = ["계절", "TPO"]
    var wearInfoViewTableViewInfoArr: [String] = []
    
    // CategoryCareView TableView data
    var categoryCareViewTableViewTitleArr: [String] = []
    
    // MaterialCareView TableView data
    var materialCareViewTableViewTitleArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertData()
        
        // NavigationBar
        initNavigationBar(title: "옷 정보")
        
        self.navigationItem.rightBarButtonItem = self.rightButton
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
        
        FirebaseFirestoreManger.db
            .collection("clothesManagement")
            .document("material")
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    if let documentData = document.data() {
                        self.materialCareData = documentData
                    }
                } else {
                    print("Document does not exist")
                }
            }
        
        FirebaseFirestoreManger.db
            .collection("clothesManagement")
            .document("category")
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    if let documentData = document.data() {
                        self.categoryCareData = documentData
                    }
                } else {
                    print("Document does not exist")
                }
            }
    }
    
    @objc private func buttonPressed(_ sender: Any) {
        let actionSheet = UIAlertController(title: "더보기", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "의류 삭제", style: .destructive, handler: { _ in
            
            let alert = UIAlertController(title: "정말 삭제하시겠습니까?", message: "이 동작은 되돌릴 수 없습니다.", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let remove = UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
                FirebaseFirestoreManger.db.collection("Closet").document(self.clothesData["documentName"] as! String).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                        
                        getClosetData {
                            print(ClosetData.shared.allClosetData)
                            
                            
                            let image = Storage.storage().reference().child("\(self.clothesData["documentName"] as! String)")
                            
                            image.delete { error in
                                if error != nil {
                                    // Uh-oh, an error occurred!
                                    print("delete error")
                                } else {
                                    // File deleted successfully
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                        }
                        
                        func getClosetData(completion: @escaping () -> Void) {
                            switch self.clothesData["category"] as! String {
                            case "상의":
                                ClosetData.shared.allClosetData.removeAll()
                                ClosetData.shared.topClosetData.removeAll()
                                
                                FirebaseFirestoreManger.db
                                    .collection("Closet")
                                    .whereField("userID", isEqualTo: FirebaseAuthManager.userID)
                                    .getDocuments() { (querySnapshot, err) in
                                        if let err = err {
                                            print("Error getting documents: \(err)")
                                        } else {
                                            for document in querySnapshot!.documents {
                                                let category = document.data()["category"] as! String
                                                if category == "상의" {
                                                    ClosetData.shared.topClosetData.append(document.data())
                                                }
                                                ClosetData.shared.allClosetData.append(document.data())
                                            }
                                        }
                                    }
                            case "하의":
                                ClosetData.shared.allClosetData.removeAll()
                                ClosetData.shared.pantsClosetData.removeAll()
                                
                                FirebaseFirestoreManger.db
                                    .collection("Closet")
                                    .whereField("userID", isEqualTo: FirebaseAuthManager.userID)
                                    .getDocuments() { (querySnapshot, err) in
                                        if let err = err {
                                            print("Error getting documents: \(err)")
                                        } else {
                                            for document in querySnapshot!.documents {
                                                let category = document.data()["category"] as! String
                                                if category == "하의" {
                                                    ClosetData.shared.topClosetData.append(document.data())
                                                }
                                                ClosetData.shared.allClosetData.append(document.data())
                                            }
                                        }
                                    }
                            case "아우터":
                                ClosetData.shared.allClosetData.removeAll()
                                ClosetData.shared.outerClosetData.removeAll()
                                
                                FirebaseFirestoreManger.db
                                    .collection("Closet")
                                    .whereField("userID", isEqualTo: FirebaseAuthManager.userID)
                                    .getDocuments() { (querySnapshot, err) in
                                        if let err = err {
                                            print("Error getting documents: \(err)")
                                        } else {
                                            for document in querySnapshot!.documents {
                                                let category = document.data()["category"] as! String
                                                if category == "아우터" {
                                                    ClosetData.shared.topClosetData.append(document.data())
                                                }
                                                ClosetData.shared.allClosetData.append(document.data())
                                            }
                                        }
                                    }
                            case "신발":
                                ClosetData.shared.allClosetData.removeAll()
                                ClosetData.shared.shoesClosetData.removeAll()
                                
                                FirebaseFirestoreManger.db
                                    .collection("Closet")
                                    .whereField("userID", isEqualTo: FirebaseAuthManager.userID)
                                    .getDocuments() { (querySnapshot, err) in
                                        if let err = err {
                                            print("Error getting documents: \(err)")
                                        } else {
                                            for document in querySnapshot!.documents {
                                                let category = document.data()["category"] as! String
                                                if category == "신발" {
                                                    ClosetData.shared.topClosetData.append(document.data())
                                                }
                                                ClosetData.shared.allClosetData.append(document.data())
                                            }
                                        }
                                    }
                            case "기타":
                                ClosetData.shared.allClosetData.removeAll()
                                ClosetData.shared.etcClosetData.removeAll()
                                
                                FirebaseFirestoreManger.db
                                    .collection("Closet")
                                    .whereField("userID", isEqualTo: FirebaseAuthManager.userID)
                                    .getDocuments() { (querySnapshot, err) in
                                        if let err = err {
                                            print("Error getting documents: \(err)")
                                        } else {
                                            for document in querySnapshot!.documents {
                                                let category = document.data()["category"] as! String
                                                if category == "기타" {
                                                    ClosetData.shared.topClosetData.append(document.data())
                                                }
                                                ClosetData.shared.allClosetData.append(document.data())
                                            }
                                        }
                                    }
                            default:
                                return
                            }
                            completion()
                        }
                    }
                }
            })
            
            alert.addAction(remove)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(actionSheet, animated: true)
    }
    
}

//MARK: init
extension ClosetDetailViewController {
    // insert Data
    func insertData() {
        // 옷 정보
        guard let detailCategory = clothesData["detailCategory"] as? String else { return }
        guard let slider = clothesData["slider"] as? Int else { return }
        guard let brand = clothesData["brand"] else { return }
        guard let colorArr = clothesData["color"] as? Array<String> else { return }
        guard let materialArr = clothesData["material"] as? Array<String> else { return }
        guard let size = clothesData["size"] else { return }
        
        var intimacy: String
        
        categoryCareViewTableViewTitleArr = [detailCategory]
        materialCareViewTableViewTitleArr = (clothesData["material"] as? Array<String>)!
        
        // 착용 정보
        guard let seasonArr = clothesData["season"] as? Array<String> else { return }
        guard let tpoArr = clothesData["tpo"] as? Array<String> else { return }
        
        switch slider {
        case 0...2:
            intimacy = "거의 안 입어요"
        case 3...4:
            intimacy = "잘 안 입어요"
        case 5...6:
            intimacy = "그냥 그래요"
        case 6...7:
            intimacy = "자주 입어요"
        case 8...10:
            intimacy = "아주 많이 입어요"
        default:
            intimacy = "입력된 정보가 없어요"
        }
        
        clothesInfoViewTableViewInfoArr = [intimacy, "\(brand)", arrToString(array: colorArr), arrToString(array: materialArr), "\(size)"]
        wearInfoViewTableViewInfoArr = [arrToString(array: seasonArr), arrToString(array: tpoArr)]
        
        func arrToString(array: Array<Any>) -> String {
            var str = ""
            var count = 0
            
            for i in array {
                if array.count != 1 {
                    str += " \(i),"
                } else {
                    str += " \(i) "
                }
                
                count += 1
                
                if count >= 3 {
                    break
                }
            }
            
            str.removeLast()
            
            return str
        }
    }
    
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
        titleViewCategoryLabel.text = clothesData["category"] as? String
        titleViewTitleLabl.text = clothesData["title"] as? String
        titleViewCategoryLabel.font = UIFont.pretendard(size: 20, family: .Bold)
        titleViewTitleLabl.font = UIFont.pretendard(size: 20, family: .Bold)
        
        // Image
        titleViewArrowIcon.image = UIImage(named: "chevronRightIcon")
        titleViewClothesImgView.kf.setImage(with: URL(string: clothesData["imageUrl"] as! String))
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
            return categoryCareViewTableViewTitleArr.count
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
            categoryCareCell.selectionStyle = .none
            categoryCareCell.title.font = UIFont.pretendard(size: 20, family: .Medium)
            categoryCareCell.Icon.image = UIImage(named: "chevronRightIcon")
            categoryCareCell.title.text = titleArr[indexPath.row]
            return categoryCareCell
        }
    }
    
    // tableViewCell 클릭 이벤트 설정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoardName = UIStoryboard(name: "ClothesCareInfoModalViewController", bundle: nil)
        let ClothesCareInfoModalViewController = storyBoardName.instantiateViewController(withIdentifier: "ClothesCareInfoModalViewController") as! ClothesCareInfoModalViewController
        
        switch tableView {
        case categoryCareViewTableView:
            ClothesCareInfoModalViewController.categoryCareData = self.categoryCareData
            ClothesCareInfoModalViewController.modalTitle = categoryCareViewTableViewTitleArr[indexPath.row]
            self.present(ClothesCareInfoModalViewController, animated: true)
            
        case materialCareViewTableView:
            ClothesCareInfoModalViewController.materialCareData = self.materialCareData
            ClothesCareInfoModalViewController.modalTitle = materialCareViewTableViewTitleArr[indexPath.row]
            self.present(ClothesCareInfoModalViewController, animated: true)
            
        default: break
        }
    }
}
