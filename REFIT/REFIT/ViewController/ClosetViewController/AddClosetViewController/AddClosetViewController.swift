import UIKit

class AddClosetViewController: UIViewController {
    // hide keyboard
    
    // imageView
    @IBOutlet weak var clothesImageView: UIImageView!
    
    // title
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextFieldBorderView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    
    // slider
    @IBOutlet weak var sliderLabel: UILabel!
    
    // category
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryTextFieldBorderView: UIView!
    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextFont()
        initNavigationBar()
        initTextField()
        initKeyboard()
        
        createPickerView()
    }
    
    // add img
    @IBAction func chageImgBtntapped(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        
        print("hi")
        
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
    
    // keyboard open, find text field
    func initKeyboard() {
        titleTextField.delegate = self
    }
    
    // PickerView
    let categoryArr: [String] = ["상의", "하의", "아우터", "신발", "기타"]
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.tintColor = .clear
        
        // 툴바 세팅
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
        categoryTextField.resignFirstResponder() /// 피커뷰 내림
    }
         
    // 피커뷰 > 취소 클릭
    @objc func onPickCancel() {
        categoryTextField.text = nil
        categoryTextField.resignFirstResponder() /// 피커뷰 내림
    }
    
    //MARK: - init
    /// init Navigation bar
    func initNavigationBar() {
        self.navigationItem.title = "옷 등록"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.pretendard(size: 18, family: .SemiBold)]
    }
    
    /// init text font
    func initTextFont() {
        // title
        titleLabel.text = "제목*"
        titleLabel.font = UIFont.pretendard(size: 18, family: .Bold)
        
        // slider
        sliderLabel.text = "옷과의 친밀도"
        sliderLabel.font = UIFont.pretendard(size: 18, family: .Bold)
        
        //category
        categoryLabel.text = "카테고리*"
        categoryLabel.font = UIFont.pretendard(size: 18, family: .Bold)
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
    
}

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

// keyboard
extension AddClosetViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == titleTextField {
        categoryTextField.becomeFirstResponder()
      } else {
        categoryTextField.resignFirstResponder()
      }
      return true
  }
}
