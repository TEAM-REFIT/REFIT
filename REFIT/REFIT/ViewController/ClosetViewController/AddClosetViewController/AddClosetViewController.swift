import UIKit

class AddClosetViewController: UIViewController,
                               UIImagePickerControllerDelegate,
                               UINavigationControllerDelegate {
    
    @IBOutlet weak var clothesImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        
        // 카메라 기능 세팅
        let camera = UIImagePickerController()
        camera.sourceType = .camera
        camera.allowsEditing = true
    }
    
    @IBAction func chageImgBtntapped(_ sender: Any) {
        print("hi")
        let actionSheet = UIAlertController(title: "의류 추가 방법", message: "의류 추가 방법을 선택해주세요.", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "사진 촬영하여 추가하기", style: .default, handler: { _ in
            print("사진 촬영하여 추가하기")
        }))
        actionSheet.addAction(UIAlertAction(title: "앨범에서 추가하기", style: .default, handler: { _ in
            print("앨법에서 추가하기")
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(actionSheet, animated: true)
    }
    
    func initNavigationBar() {
        //remove navigation bar item title
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    /// use photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            clothesImageView.image = image
        }

        picker.dismiss(animated: true, completion: nil)
    }
    
    /// cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
}
