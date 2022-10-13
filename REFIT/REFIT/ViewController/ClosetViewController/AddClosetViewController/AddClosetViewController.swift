import UIKit

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
    
    // slider
    @IBOutlet weak var sliderLabel: UILabel!
    
    // season
    @IBOutlet weak var seasonLabel: UILabel!
    
    @IBOutlet weak var springBtn: UIButton!
    @IBOutlet weak var summerBtn: UIButton!
    @IBOutlet weak var fallBtn: UIButton!
    @IBOutlet weak var winterBtn: UIButton!
    
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
    
    // material
    @IBOutlet weak var materialLabel: UILabel!
    @IBOutlet var materialBtn: [UIButton]!
    
    // registration
    @IBOutlet weak var registrationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTitleLabel()
        initNavigationBar()
        initTextField()
        initKeyboard()
        initseasonBtn()
        initColorBtn()
        initTpoBtn()
        initMaterialBtn()
        initRegistrationBtn()
        
        initPickerView()
    }
    
    // MARK: - Action
    // Image view
    // add img
    @IBAction func chageImgBtntapped(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        
        let actionSheet = UIAlertController(title: "의류 추가 방법", message: "의류 추가 방법을 선택해주세요.", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "사진 촬영하여 추가하기", style: .default, handler: { _ in
                self.present(picker, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "앨범에서 추가하기", style: .default, handler: { _ in
            print("앨법에서 추가하기")
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(actionSheet, animated: true)
    }
    
    // season
    @IBAction func seasonBtnTapped(_ sender: UIButton) {
        if sender == springBtn {
            
            if springBtn.isSelected == false {
                selectedButtonDesign(button: sender)
            } else {
                notSelectedButtonDesign(button: sender)
            }
            
        } else if sender == summerBtn {
            
            if summerBtn.isSelected == false {
                selectedButtonDesign(button: sender)
            } else {
                notSelectedButtonDesign(button: sender)
            }
            
        } else if sender == fallBtn {
            
            if fallBtn.isSelected == false {
                selectedButtonDesign(button: sender)
            } else {
                notSelectedButtonDesign(button: sender)
            }
            
        } else {
            
            if winterBtn.isSelected == false {
                selectedButtonDesign(button: sender)
            } else {
                notSelectedButtonDesign(button: sender)
            }
            
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
    
    
    // MARK: - UI setting
    // PickerView
    let categoryArr: [String] = ["상의", "하의", "아우터", "신발", "기타"]
    
    func initPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.tintColor = .clear
        
        // tool bar setting
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(onPickCancel))
        toolBar.setItems([btnCancel , space , btnDone], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        categoryTextField.inputView = pickerView
        categoryTextField.inputAccessoryView = toolBar
    }
    
    // 피커뷰 > 확인 클릭
    @objc func onPickDone() {
        // Hide PickerView
        categoryTextField.resignFirstResponder()
    }
         
    // 피커뷰 > 취소 클릭
    @objc func onPickCancel() {
        // Hide PickerView
        categoryTextField.text = nil
        categoryTextField.resignFirstResponder()
    }
    
    //MARK: - init
    /// init Navigation bar
    func initNavigationBar() {
        self.navigationItem.title = "옷 등록"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.pretendard(size: 18, family: .SemiBold)]
    }
    
    /// init text font
    func initTitleLabel() {
        // title label
        titleLabelDesign(label: titleLabel, text: "제목*")
        
        //category label
        titleLabelDesign(label: categoryLabel, text: "카테고리*")
        
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
        
        // material Label
        titleLabelDesign(label: materialLabel, text: "소재")
        func titleLabelDesign(label: UILabel, text: String) {
            label.text = text
            label.font = UIFont.pretendard(size: 18, family: .Bold)
        }
    }
    
    /// initTextField
    func initTextField() {
        // title text field
        textFieldDesign(textfieldBorderView: titleTextFieldBorderView, textField: titleTextField, placeholder: "제목을 입력해주세요!")
        
        // category text field
        textFieldDesign(textfieldBorderView: categoryTextFieldBorderView, textField: categoryTextField, placeholder: "카테고리를 선택해주세요!")
        
        // size text field
        textFieldDesign(textfieldBorderView: sizeTextFieldBorderView, textField: sizeTextField, placeholder: "ex) S, M, L")
        func textFieldDesign(textfieldBorderView: UIView, textField: UITextField, placeholder: String) {
            textfieldBorderView.layer.cornerRadius = 25
            textfieldBorderView.layer.borderWidth = 1
            textfieldBorderView.layer.borderColor = UIColor.lightGray.cgColor
            
            textField.font = UIFont.pretendard(size: 16, family: .Regular)
            textField.placeholder = placeholder
        }
    }
    
    /// init keyboard
    func initKeyboard() {
        titleTextField.delegate = self
        categoryTextField.delegate = self
        sizeTextField.delegate = self
        }
    
    /// init  season button
    func initseasonBtn() {
        initBtn(button: springBtn, title: "봄")
        initBtn(button: summerBtn, title: "여름")
        initBtn(button: fallBtn, title: "가을")
        initBtn(button: winterBtn, title: "겨울")
        
        func initBtn(button: UIButton, title: String) {
            button.setTitle(title, for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.titleLabel?.font = UIFont.pretendard(size: 16, family: .Regular)
            button.tintColor = UIColor.clear
            button.layer.cornerRadius = 25
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    /// color button
    func initColorBtn() {
          for i in colorBtn {
              i.layer.cornerRadius = 0.5 * i.bounds.size.width
              i.layer.borderWidth = 1
              i.layer.borderColor = UIColor.gray.cgColor
              i.tintColor = UIColor.clear
          }
        }
    
    /// TPO button
    func initTpoBtn() {
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
    func initMaterialBtn() {
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
    func initRegistrationBtn() {
        registrationBtn.setTitleColor(.white, for: .normal)
        registrationBtn.backgroundColor = UIColor.black
    }
}

//MARK: - Extension
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

extension AddClosetViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categoryArr[row]
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
            
        default:
            return
        }
    }
    
    // keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          if textField == titleTextField {
            textField.resignFirstResponder()
            categoryTextField.becomeFirstResponder()
          }
          return true
      }
}
