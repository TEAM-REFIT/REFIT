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
    
    // season button
    @IBOutlet weak var seasonLabel: UILabel!
    
    @IBOutlet weak var springBtn: UIButton!
    @IBOutlet weak var summerBtn: UIButton!
    @IBOutlet weak var fallBtn: UIButton!
    @IBOutlet weak var winterBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextFont()
        initNavigationBar()
        initTextField()
        initKeyboard()
        initseasonBtn()
        
        createPickerView()
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
                springBtn.backgroundColor = UIColor.darkGray
                springBtn.setTitleColor(.white, for: .selected)
                springBtn.isSelected = true
            } else {
                springBtn.backgroundColor = UIColor.white
                springBtn.setTitleColor(.gray, for: .normal)
                springBtn.isSelected = false
            }
        } else if sender == summerBtn {
            if summerBtn.isSelected == false {
                summerBtn.backgroundColor = UIColor.darkGray
                summerBtn.setTitleColor(.white, for: .selected)
                summerBtn.isSelected = true
            } else {
                summerBtn.backgroundColor = UIColor.white
                summerBtn.setTitleColor(.gray, for: .normal)
                summerBtn.isSelected = false
            }
        } else if sender == fallBtn {
            if fallBtn.isSelected == false {
                fallBtn.backgroundColor = UIColor.darkGray
                fallBtn.setTitleColor(.white, for: .selected)
                fallBtn.isSelected = true
            } else {
                fallBtn.backgroundColor = UIColor.white
                fallBtn.setTitleColor(.gray, for: .normal)
                fallBtn.isSelected = false
            }
        } else {
            if winterBtn.isSelected == false {
                winterBtn.backgroundColor = UIColor.darkGray
                winterBtn.setTitleColor(.white, for: .selected)
                winterBtn.isSelected = true
            } else {
                winterBtn.backgroundColor = UIColor.white
                winterBtn.setTitleColor(.gray, for: .normal)
                winterBtn.isSelected = false
            }
        }
    }
    // MARK: - UI setting
    // PickerView
    let categoryArr: [String] = ["상의", "하의", "아우터", "신발", "기타"]
    
    func createPickerView() {
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
    func initTextFont() {
        // title label
        titleLabel.text = "제목*"
        titleLabel.font = UIFont.pretendard(size: 18, family: .Bold)
        
        //category label
        categoryLabel.text = "카테고리*"
        categoryLabel.font = UIFont.pretendard(size: 18, family: .Bold)
        
        // slider label
        sliderLabel.text = "옷과의 친밀도"
        sliderLabel.font = UIFont.pretendard(size: 18, family: .Bold)
        
        // season label
        seasonLabel.text = "계절"
        seasonLabel.font = UIFont.pretendard(size: 18, family: .Bold)
    }
    
    /// initTextField
    func initTextField() {
        // title text field
        titleTextFieldBorderView.layer.cornerRadius = 22
        titleTextFieldBorderView.layer.borderWidth = 1
        titleTextFieldBorderView.layer.borderColor = UIColor.lightGray.cgColor
        
        titleTextField.font = UIFont.pretendard(size: 16, family: .Regular)
        titleTextField.placeholder = "ex)"
        
        // category text field
        categoryTextFieldBorderView.layer.cornerRadius = 22
        categoryTextFieldBorderView.layer.borderWidth = 1
        categoryTextFieldBorderView.layer.borderColor = UIColor.lightGray.cgColor
        
        categoryTextField.font = UIFont.pretendard(size: 16, family: .Regular)
        categoryTextField.placeholder = "카테고리를 선택해주세요!"
    }
    
    /// init keyboard
    func initKeyboard() {
        titleTextField.delegate = self
        categoryTextField.delegate = self
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
            button.tintColor = UIColor.clear
            button.titleLabel?.font = UIFont.pretendard(size: 16, family: .Regular)
            button.layer.cornerRadius = 25
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
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
        let SelectTextField = textField
        switch SelectTextField {
        case titleTextField:
            titleTextFieldBorderView.layer.cornerRadius = 22
            titleTextFieldBorderView.layer.borderWidth = 1
            titleTextFieldBorderView.layer.borderColor = UIColor.green.cgColor
            
        case categoryTextField:
            categoryTextFieldBorderView.layer.cornerRadius = 22
            categoryTextFieldBorderView.layer.borderWidth = 1
            categoryTextFieldBorderView.layer.borderColor = UIColor.green.cgColor
        default:
            return
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let SelectTextField = textField
        switch SelectTextField {
        case titleTextField:
            titleTextFieldBorderView.layer.cornerRadius = 22
            titleTextFieldBorderView.layer.borderWidth = 1
            titleTextFieldBorderView.layer.borderColor = UIColor.lightGray.cgColor
        
        case categoryTextField:
            categoryTextFieldBorderView.layer.cornerRadius = 22
            categoryTextFieldBorderView.layer.borderWidth = 1
            categoryTextFieldBorderView.layer.borderColor = UIColor.lightGray.cgColor
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
