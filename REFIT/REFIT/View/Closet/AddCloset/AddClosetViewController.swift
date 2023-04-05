import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AddClosetViewController: UIViewController {
    // MARK: - Outlet
    // image view
    @IBOutlet weak var clothesImageView: UIImageView!
    
    // title
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextFieldBorderView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    
    // category
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categoryTextFieldBorderView: UIView!
    @IBOutlet weak var categoryTextField: UITextField!
    let categoryPickerView = UIPickerView()
    
    @IBOutlet var detailCategoryTextFieldBorderView: UIView!
    @IBOutlet var detailCategoryTextField: UITextField!
    let detailCategoryPickerView = UIPickerView()
    
    // slider
    @IBOutlet weak var sliderLabel: UILabel!
    
    // season
    @IBOutlet weak var seasonLabel: UILabel!
    
    @IBOutlet var seasonBtn: [UIButton]!
    
    // color
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet var colorBtn: [UIButton]!
    
    // TPO
    @IBOutlet weak var tpoLabel: UILabel!
    @IBOutlet var tpoBtn: [UIButton]!
    
    // size
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeTextFieldBorderView: UIView!
    @IBOutlet weak var sizeTextField: UITextField!
    
    // brand
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var brandTextFieldBorderView: UIView!
    @IBOutlet var brandTextField: UITextField!
    
    // material
    @IBOutlet weak var materialLabel: UILabel!
    @IBOutlet var materialBtn: [UIButton]!
    
    // registration
    @IBOutlet weak var registrationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTitleLabel()
        initNavigationBar()
        
        initClothesImageView()
        initTextField()
        initKeyboard()
        initseasonBtn()
        initColorBtn()
        initTpoBtn()
        initMaterialBtn()
        initRegistrationBtn()
        
        initCategoryPickerView()
        initDetailCategoryPickerView()
        
        indicatorView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // animateRegistrationBtn()
    }
    
    // Indicator
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    // MARK: - Action
    // Image view
    // add img
    @IBAction func changeImgBtntapped(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        let actionSheet = UIAlertController(title: "의류 추가 방법", message: "의류 추가 방법을 선택해주세요.", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "사진 촬영하여 추가하기", style: .default, handler: { _ in
            picker.sourceType = .camera
            self.present(picker, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "앨범에서 추가하기", style: .default, handler: { _ in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(actionSheet, animated: true)
    }
    
    // season
    @IBAction func seasonBtnTapped(_ sender: UIButton) {
        if sender.isSelected == false {
            selectedButtonDesign(button: sender)
        } else {
            notSelectedButtonDesign(button: sender)
        }
        
        func selectedButtonDesign(button: UIButton) {
            button.backgroundColor = UIColor.darkGray
            button.setTitleColor(.white, for: .selected)
            button.isSelected = true
        }
        
        func notSelectedButtonDesign(button: UIButton) {
            button.backgroundColor = UIColor.white
            button.setTitleColor(.gray, for: .normal)
            button.isSelected = false
        }
    }
    
    //slider
    var sliderValue = 5
    @IBAction func sliderScroll(_ sender: UISlider) {
        sliderValue = Int(sender.value)
    }
    
    // color
    @IBAction func colorBtnTapped(_ sender: UIButton) {
        if sender.isSelected == false {
            selectedButtonDesign(button: sender)
        } else {
            notSelectedButtonDesign(button: sender)
        }
        
        func selectedButtonDesign(button: UIButton) {
            if button.backgroundColor == UIColor.black {
                button.setImage(UIImage(named: "whiteCheckIcon"), for: .selected)
                button.isSelected = true
            } else {
                button.setImage(UIImage(named: "blackCheckIcon"), for: .selected)
                button.isSelected = true
            }
        }
        
        func notSelectedButtonDesign(button: UIButton) {
            button.setImage(UIImage(), for: .normal)
            button.isSelected = false
        }
    }
    
    // TPO
    @IBAction func tpoBtnTapped(_ sender: UIButton) {
        if sender.isSelected == false {
            selectedButtonDesign(button: sender)
        } else {
            notSelectedButtonDesign(button: sender)
        }
        
        func selectedButtonDesign(button: UIButton) {
            button.backgroundColor = UIColor.darkGray
            button.setTitleColor(.white, for: .selected)
            button.isSelected = true
        }
        
        func notSelectedButtonDesign(button: UIButton) {
            button.backgroundColor = UIColor.white
            button.setTitleColor(.gray, for: .normal)
            button.isSelected = false
        }
    }
    
    // material
    @IBAction func materialBtnTapped(_ sender: UIButton) {
        if sender.isSelected == false {
            selectedButtonDesign(button: sender)
        } else {
            notSelectedButtonDesign(button: sender)
        }
        
        func selectedButtonDesign(button: UIButton) {
            button.backgroundColor = UIColor.darkGray
            button.setTitleColor(.white, for: .selected)
            button.isSelected = true
        }
        
        func notSelectedButtonDesign(button: UIButton) {
            button.backgroundColor = UIColor.white
            button.setTitleColor(.gray, for: .normal)
            button.isSelected = false
        }
    }
    
    // registration
    @IBAction func registrationBtnTapped(_ sender: UIButton) {
        let clothesName = FirebaseAuthManager.userID + "_" + UUID().uuidString
        
        showIndicator(self)
        // 이미지가 선택되었을 때만 다음 단계로 이동
        if clothesImageView.image != UIImage(imageLiteralResourceName: "addImageViewImg"),
           titleTextField.text?.isEmpty == false,
           categoryTextField.text?.isEmpty == false,
           detailCategoryTextField.text?.isEmpty == false,
           sizeTextField.text?.isEmpty == false,
           brandTextField.text?.isEmpty == false,
           btnIsSelected(button: seasonBtn),
           btnIsSelected(button: colorBtn),
           btnIsSelected(button: tpoBtn),
           btnIsSelected(button: materialBtn) {
            // Firesbase Storeage
            FirebaseStorageManager.uploadImage(name: clothesName, image: clothesImageView.image!) { url in
                // Firestore
                guard let imageUrl = url?.absoluteString.replacingOccurrences(of: "//", with: "/") else { return }
                
                addClothesData(clothesName: clothesName,
                               userID: FirebaseAuthManager.userID,
                               imageUrl: imageUrl,
                               title: self.titleTextField.text!,
                               category: self.categoryTextField.text!,
                               detailCategory: self.detailCategoryTextField.text!,
                               slider: self.sliderValue,
                               season: btnValue(button: self.seasonBtn),
                               color: colorBtnValue(button: self.colorBtn),
                               tpo: btnValue(button: self.tpoBtn),
                               size: self.sizeTextField.text!,
                               brand: self.brandTextField.text!,
                               material: btnValue(button: self.materialBtn))
                
                addLocalData {
                    self.navigationController?.popViewController(animated: true)
                }
                
                func addLocalData(completion: @escaping () -> Void) {
                    let clothes: [String : Any] = ["userID": FirebaseAuthManager.userID,
                                                   "imageUrl" : imageUrl,
                                                   "title" : self.titleTextField.text ?? "무제",
                                                   "documentName" : clothesName,
                                                   "category" : self.categoryTextField.text ?? "선택 없음",
                                                   "detailCategory" : self.detailCategoryTextField.text!,
                                                   "slider" : self.sliderValue,
                                                   "season" : btnValue(button: self.seasonBtn),
                                                   "color" : colorBtnValue(button: self.colorBtn),
                                                   "tpo" : btnValue(button: self.tpoBtn),
                                                   "size" : self.sizeTextField.text ?? "선택 없음",
                                                   "brand" : self.brandTextField.text ?? "선택없음",
                                                   "material" : btnValue(button: self.materialBtn)]
                    
                    let category = clothes["category"] as! String
                    switch category {
                    case "상의":
                        ClosetData.shared.topClosetData.append(clothes)
                    case "하의":
                        ClosetData.shared.pantsClosetData.append(clothes)
                    case "아우터":
                        ClosetData.shared.outerClosetData.append(clothes)
                    case "신발":
                        ClosetData.shared.shoesClosetData.append(clothes)
                    case "기타":
                        ClosetData.shared.etcClosetData.append(clothes)
                    default:
                        break
                    }
                    ClosetData.shared.allClosetData.append(clothes)
                    completion()
                }
            }
        } else {
            hideIndicator(self)
            // 의류 정보들이 다 기입되지 않았을 때
            let alert = UIAlertController(title: "정보가 모두 입력되지 않았어요!", message: "정보를 모두 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: false, completion: nil)
        }
        
        func btnIsSelected(button: [UIButton]) -> Bool {
            var select = false
            
            for i in button {
                if i.isSelected {
                    select = true
                    return select
                }
            }
            
            return select
        }
        
        // seasonBtn, tpoBtn
        func btnValue(button: [UIButton]) -> [String] {
            var arr = [""]
            arr = []
            for i in button {
                if i.isSelected {
                    arr.append(i.titleLabel?.text ?? "cannot find title label")
                }
            }
            return arr
        }
        
        // colorBtn
        func colorBtnValue(button: [UIButton]) -> [String] {
            let colorArr = ["화이트", "옐로우", "오렌지", "레드", "핑크", "퍼플", "블루", "그린", "베이지", "브라운", "블랙", "그레이"]
            var arr = [""]
            arr = []
            for i in 0...11 {
                if button[i].isSelected {
                    arr.append(colorArr[i])
                }
            }
            return arr
        }
    }
    
    // MARK: - UI setting
    // category PickerView
    let categoryArr = ["상의", "하의", "아우터", "신발", "기타"]
    
    let notSelectArr = ["카테고리를 먼저 선택해주세요!"]
    
    let topCategoryArr = ["티셔츠", "맨투맨", "후드", "셔츠", "니트"]
    let pantsCategoryArr = ["슬랙스(정장바지)", "청바지", "치마", "면바지"]
    let outerCategoryArr = ["패딩", "코트", "자켓"]
    let shoesCategoryArr = ["캔버스화", "운동화", "가죽 신발", "스웨이드 슈즈"]
    let etcCategoryArr = ["원피스", "천모자", "비니(털모자)", "목도리", "가방"]
    
    
    // PickerView setting
    func initCategoryPickerView() {
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        
        categoryTextField.tintColor = .clear
        
        // tool bar setting
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(CategoryOnPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(CategoryOnPickCancel))
        toolBar.setItems([btnCancel , space , btnDone], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        categoryTextField.inputView = categoryPickerView
        categoryTextField.inputAccessoryView = toolBar
    }
    
    @objc func CategoryOnPickDone() {
        // Hide PickerView
        categoryTextField.resignFirstResponder()
    }
    
    @objc func CategoryOnPickCancel() {
        // Hide PickerView
        categoryTextField.text = nil
        categoryTextField.resignFirstResponder()
    }
    
    func initDetailCategoryPickerView() {
        detailCategoryPickerView.delegate = self
        detailCategoryPickerView.dataSource = self
        
        detailCategoryTextField.tintColor = .clear
        
        // tool bar setting
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(detailCategoryOnPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(detailCategoryOnPickCancel))
        toolBar.setItems([btnCancel , space , btnDone], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        detailCategoryTextField.inputView = detailCategoryPickerView
        detailCategoryTextField.inputAccessoryView = toolBar
    }
    
    @objc func detailCategoryOnPickDone() {
        // Hide PickerView
        detailCategoryTextField.resignFirstResponder()
    }
    
    @objc func detailCategoryOnPickCancel() {
        // Hide PickerView
        detailCategoryTextField.text = nil
        detailCategoryTextField.resignFirstResponder()
    }
}

//MARK: - init
extension AddClosetViewController {
    /// init Navigation bar
    private func initNavigationBar() {
        self.navigationItem.title = "옷 등록"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.pretendard(size: 18, family: .SemiBold)]
    }
    
    /// init text font
    private func initTitleLabel() {
        // title label
        titleLabelDesign(label: titleLabel, text: "제목")
        
        //category label
        titleLabelDesign(label: categoryLabel, text: "카테고리")
        
        // slider label
        titleLabelDesign(label: sliderLabel, text: "옷과의 친밀도")
        
        // season label
        titleLabelDesign(label: seasonLabel, text: "계절")
        
        // color label
        titleLabelDesign(label: colorLabel, text: "색상")
        
        // TPO Label
        titleLabelDesign(label: tpoLabel, text: "TPO")
        
        // size Label
        titleLabelDesign(label: sizeLabel, text: "사이즈")
        
        // brand Label
        titleLabelDesign(label: brandLabel, text: "브랜드")
        
        // material Label
        titleLabelDesign(label: materialLabel, text: "소재")
        
        func titleLabelDesign(label: UILabel, text: String) {
            label.text = text
            label.font = UIFont.pretendard(size: 18, family: .Bold)
        }
    }
    
    /// imgView
    private func initClothesImageView() {
        clothesImageView.layer.cornerRadius = 25
        clothesImageView.image = UIImage(named: "addImageViewImg")
    }
    
    /// initTextField
    private func initTextField() {
        // title text field
        textFieldDesign(textfieldBorderView: titleTextFieldBorderView, textField: titleTextField, placeholder: "제목을 입력해주세요!")
        
        // category text field
        textFieldDesign(textfieldBorderView: categoryTextFieldBorderView, textField: categoryTextField, placeholder: "카테고리를 선택해주세요!")
        textFieldDesign(textfieldBorderView: detailCategoryTextFieldBorderView, textField: detailCategoryTextField, placeholder: "상세 카테고리를 선택해주세요!")
        
        // size text field
        textFieldDesign(textfieldBorderView: sizeTextFieldBorderView, textField: sizeTextField, placeholder: "ex) S, M, L")
        
        // brand text field
        textFieldDesign(textfieldBorderView: brandTextFieldBorderView, textField: brandTextField, placeholder: "ex) 나이키")
        
        func textFieldDesign(textfieldBorderView: UIView, textField: UITextField, placeholder: String) {
            textfieldBorderView.layer.cornerRadius = 25
            textfieldBorderView.layer.borderWidth = 1
            textfieldBorderView.layer.borderColor = UIColor.lightGray.cgColor
            
            textField.font = UIFont.pretendard(size: 16, family: .Regular)
            textField.placeholder = placeholder
        }
    }
    
    /// init keyboard
    private func initKeyboard() {
        titleTextField.delegate = self
        categoryTextField.delegate = self
        detailCategoryTextField.delegate = self
        sizeTextField.delegate = self
        brandTextField.delegate = self
    }
    
    /// init  season button
    private func initseasonBtn() {
        let seasonBtnTitleText = ["봄", "여름", "가을", "겨울"]
        var seasonBtnIndex = 0
        for i in seasonBtn {
            i.setTitle(seasonBtnTitleText[seasonBtnIndex], for: .normal)
            i.setTitleColor(.gray, for: .normal)
            i.titleLabel?.font = UIFont.pretendard(size: 16, family: .Regular)
            i.tintColor = UIColor.clear
            i.layer.cornerRadius = 25
            i.layer.borderWidth = 1
            i.layer.borderColor = UIColor.lightGray.cgColor
            seasonBtnIndex += 1
        }
    }
    
    /// color button
    private func initColorBtn() {
        for i in colorBtn {
            if UIDevice.current.userInterfaceIdiom == .pad {
                var half: CGFloat = 1.15
                
                // 아이패드 12.9인치
                if UIScreen.main.bounds.width > 1023 {
                    half = 1.5
                } else {
                    if UIScreen.main.bounds.width < 770 {
                        half = 1
                    }
                }
                
                i.layer.cornerRadius = half * i.frame.width
            } else {
                if UIScreen.main.bounds.size.width > 375 {
                    i.layer.cornerRadius = 0.5 * i.frame.width
                } else {
                    i.layer.cornerRadius = 0.45 * i.frame.width
                }
            }

            i.layer.borderWidth = 1
            i.layer.borderColor = UIColor.gray.cgColor
            i.tintColor = UIColor.clear
        }
    }
    
    /// TPO button
    private func initTpoBtn() {
        let tpoBtnTitleText = ["데이트", "비즈니스", "여행", "운동", "유니폼", "데일리", "경조사", "기타"]
        var tpoBtnIndex = 0
        for i in tpoBtn {
            i.setTitle(tpoBtnTitleText[tpoBtnIndex], for: .normal)
            i.setTitleColor(.gray, for: .normal)
            i.titleLabel?.font = UIFont.pretendard(size: 16, family: .Regular)
            i.tintColor = UIColor.clear
            i.layer.cornerRadius = 25
            i.layer.borderWidth = 1
            i.layer.borderColor = UIColor.lightGray.cgColor
            tpoBtnIndex += 1
        }
    }
    
    /// material button
    private func initMaterialBtn() {
        let materialBtnTitleText = ["면", "린넨", "폴리에스테르", "나일론", "벨벳", "가죽", "퍼", "실크", "데님", "트위드", "쉬폰", "코듀로이", "스웨이드", "니트 / 울", "메탈릭", "레이스", "기타"]
        var materialBtnIndex = 0
        for i in materialBtn {
            i.setTitle(materialBtnTitleText[materialBtnIndex], for: .normal)
            i.setTitleColor(.gray, for: .normal)
            i.titleLabel?.font = UIFont.pretendard(size: 16, family: .Regular)
            i.tintColor = UIColor.clear
            i.layer.cornerRadius = 25
            i.layer.borderWidth = 1
            i.layer.borderColor = UIColor.lightGray.cgColor
            materialBtnIndex += 1
        }
    }
    
    /// registration button
    private func initRegistrationBtn() {
        registrationBtn.layer.cornerRadius = 25
        registrationBtn.setTitleColor(.white, for: .normal)
        registrationBtn.backgroundColor = UIColor.black
    }
}

// image view
extension AddClosetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage else {
            return
        }
        clothesImageView.image = image
    }
}

// category pickerView
extension AddClosetViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case categoryPickerView:
            return categoryArr.count
        case detailCategoryPickerView:
            
            switch categoryTextField.text {
            case "상의":
                return topCategoryArr.count
            case "하의":
                return pantsCategoryArr.count
            case "아우터":
                return outerCategoryArr.count
            case "신발":
                return shoesCategoryArr.count
            case "기타":
                return etcCategoryArr.count
            default:
                return notSelectArr.count
            }
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case categoryPickerView:
            return categoryArr[row]
        case detailCategoryPickerView:
            
            switch categoryTextField.text {
            case "상의":
                return topCategoryArr[row]
            case "하의":
                return pantsCategoryArr[row]
            case "아우터":
                return outerCategoryArr[row]
            case "신발":
                return shoesCategoryArr[row]
            case "기타":
                return etcCategoryArr[row]
            default:
                return notSelectArr[row]
            }
            
        default:
            return notSelectArr[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case categoryPickerView:
            categoryTextField.text = categoryArr[row]
        case detailCategoryPickerView:
            
            switch categoryTextField.text {
            case "상의":
                detailCategoryTextField.text = topCategoryArr[row]
            case "하의":
                detailCategoryTextField.text = pantsCategoryArr[row]
            case "아우터":
                detailCategoryTextField.text = outerCategoryArr[row]
            case "신발":
                detailCategoryTextField.text = shoesCategoryArr[row]
            case "기타":
                detailCategoryTextField.text = etcCategoryArr[row]
            default:
                detailCategoryTextField.text = nil
            }
            
        default:
            categoryTextField.text = nil
            detailCategoryTextField.text = nil
        }
    }
}

// text field, keyboard
extension AddClosetViewController: UITextFieldDelegate {
    // text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let SelectedTextField = textField
        switch SelectedTextField {
        case titleTextField:
            titleTextFieldBorderView.layer.borderColor = UIColor.green.cgColor
            
        case categoryTextField:
            categoryTextFieldBorderView.layer.borderColor = UIColor.green.cgColor
            
        case sizeTextField:
            sizeTextFieldBorderView.layer.borderColor = UIColor.green.cgColor
            
        case brandTextField:
            brandTextFieldBorderView.layer.borderColor = UIColor.green.cgColor
            
        default:
            return
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let SelectedTextField = textField
        switch SelectedTextField {
        case titleTextField:
            titleTextFieldBorderView.layer.borderColor = UIColor.lightGray.cgColor
            
        case categoryTextField:
            categoryTextFieldBorderView.layer.borderColor = UIColor.lightGray.cgColor
            
        case sizeTextField:
            sizeTextFieldBorderView.layer.borderColor = UIColor.lightGray.cgColor
            
        case brandTextField:
            brandTextFieldBorderView.layer.borderColor = UIColor.lightGray.cgColor
            
        default:
            return
        }
    }
    
    // keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            textField.resignFirstResponder()
            categoryTextField.becomeFirstResponder()
        } else if textField == sizeTextField {
            textField.resignFirstResponder()
            brandTextField.becomeFirstResponder()
        } else if textField == brandTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - animation
//extension AddClosetViewController {
//    private func animateRegistrationBtn() {
//        UIView.animate(withDuration: 1.0, delay: 0,options: [.repeat, .autoreverse], animations: {
//            self.registrationBtn.frame.origin.y += 10
//        })
//    }
//
//}

extension AddClosetViewController {
    /// Indicator 보여주기
    private func showIndicator(_ viewController: AddClosetViewController) {
        viewController.indicatorView.isHidden = false
        viewController.indicatorView.startAnimating()
    }
    
    /// Indicator 숨기기
    private func hideIndicator(_ viewController: AddClosetViewController) {
        viewController.indicatorView.isHidden = true
        viewController.indicatorView.stopAnimating()
    }
}
