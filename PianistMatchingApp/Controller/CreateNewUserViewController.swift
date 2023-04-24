//
//  CreateNewUserViewController.swift
//  PianistMatchingApp
//
//  Created by 仲優樹 on 2023/04/23.
//

import UIKit
import Firebase
import AVFoundation

class CreateNewUserViewController: UIViewController,UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,ProfileSendDone {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var textField6: UITextField!
    @IBOutlet weak var quickWordTextField: UITextField!
    
    @IBOutlet weak var toProfileButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var player = AVPlayer()
    
    var agePicker = UIPickerView()
    var heightPicker = UIPickerView()
    var bloodPicker = UIPickerView()
    var prefecturePicker = UIPickerView()
    // 北海道〜沖縄,A型〜O型
    var dataStringArray = [String]()
    // 18歳〜80歳
    var dataIntArray = [Int]()
    var gender = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpVideo()
        
        textField2.inputView = agePicker
        textField3.inputView = heightPicker
        textField4.inputView = bloodPicker
        textField5.inputView = prefecturePicker
        
        agePicker.delegate = self
        agePicker.dataSource = self
        heightPicker.delegate = self
        heightPicker.dataSource = self
        bloodPicker.delegate = self
        bloodPicker.dataSource = self
        prefecturePicker.delegate = self
        prefecturePicker.dataSource = self
        
        agePicker.tag = 1
        heightPicker.tag = 2
        bloodPicker.tag = 3
        prefecturePicker.tag = 4
        
        gender = "男性"
        
        Util.rectButton(button: toProfileButton)
        Util.rectButton(button: doneButton)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //行数を決める
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
            
        case 1:
            dataIntArray = ([Int])(18...80)
            return dataIntArray.count
        case 2:
            dataIntArray = ([Int])(130...200)
            return dataIntArray.count
        case 3:
            dataStringArray = ["A型","B型","AB型","O型"]
            return dataStringArray.count
        case 4:
            dataStringArray = Util.prefectures()
            return dataStringArray.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
            
        case 1:
            textField2.text = String(dataIntArray[row]) + "歳"
            textField2.resignFirstResponder()
            break
        case 2:
            textField3.text = String(dataIntArray[row]) + "cm"
            textField3.resignFirstResponder()
            break
        case 3:
            textField4.text = dataStringArray[row] + "型"
            textField4.resignFirstResponder()
            break
        case 4:
            textField5.text = dataStringArray[row]
            textField5.resignFirstResponder()
            break
        default:
            break
            
        }
        
    }
    // 行に記載する文字列
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
            
        case 1:
            return String(dataIntArray[row]) + "歳"
        case 2:
            return String(dataIntArray[row]) + "cm"
        case 3:
            return dataStringArray[row] + "型"
        case 4:
            return dataStringArray[row]
        default:
            return ""
            
        }
        
    }
    
    @IBAction func genderSwitch(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            gender = "男性"
        }else{
            gender = "女性"
        }
        
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        // firestoreへ値を送信する
        let manager = Manager.shared.profile
        // 送信
        Auth.auth().signInAnonymously { result, error in
            
            if error != nil{
                print(error.debugDescription)
                return
            }
            
            if let range1 = self.textField2.text?.ranges(of: "歳"){
                self.textField2.text?.replaceSubrange(range1, with: "")
            }
            
            if let range2 = self.textField2.text?.ranges(of: "cm"){
                self.textField3.text?.replaceSubrange(range2, with: "")
            }
            
            let userdata = UserDataModel(name:
                self.textField1.text, age:
                self.textField2.text, height:
                self.textField3.text, bloodType:
                self.textField4.text, prefecture:
                self.textField5.text, gender:self.gender,
                profile: manager, profileImageString: "", uid:
                Auth.auth().currentUser?.uid, quickWord:
                self.quickWordTextField.text, work:
                self.textField6.text, date:
                Date().timeIntervalSince(<#T##date: Date##Date#>), onlineORNot:
                true)
            
            let sendDBModel = SendDBModel()
            sendDBModel.profileSendDone = self
            SendDBModel.sendProfileData(userData: userdata,
                profileImageData:
                (self.imageView.image?.jpegData(compressionQuality:
                0.4))!)
            
        }
        
    }
    // 呼ばれるタイミング
    func profileSendDone() {
        
        dismiss(animated: true,completion: nil)
        
    }
    
    @IBAction func tap(_ sender: Any) {
        // カメラ or アルバムを起動
        openCamera()
        
    }
    
    func openCamera(){
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            //            cameraPicker.showsCameraControls = true
            present(cameraPicker, animated: true, completion: nil)
            
        }else{
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let pickedImage = info[.editedImage] as? UIImage
        {
            imageView.image = pickedImage
            //閉じる処理
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func setUpVideo(){
        //ファイルパス
        player = AVPlayer(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/pianistmatchingapp.appspot.com/o/-134486.mp4?alt=media&token=84ca9c74-0788-40a4-91e8-07053717c250")!)
        
        //AVPlayer用のレイヤーを生成
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.repeatCount = 0 //無限ループ(終わったらまた再生のイベント後述)
        playerLayer.zPosition = -1
        view.layer.insertSublayer(playerLayer, at: 0)
        
        //終わったらまた再生
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime, //終わったr前に戻す
            object: player.currentItem,
            queue: .main) { (_) in
                
                self.player.seek(to: .zero)//開始時間に戻す
                self.player.play()
                
            }
        
        self.player.play()
        
    }
    
    
}
