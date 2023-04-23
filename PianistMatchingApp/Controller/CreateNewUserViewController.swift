//
//  CreateNewUserViewController.swift
//  PianistMatchingApp
//
//  Created by 仲優樹 on 2023/04/23.
//

import UIKit

class CreateNewUserViewController: UIViewController,UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var textField6: UITextField!
    @IBOutlet weak var quickWordTextField: UITextField!
    
    @IBOutlet weak var toProfileButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
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
    
}
