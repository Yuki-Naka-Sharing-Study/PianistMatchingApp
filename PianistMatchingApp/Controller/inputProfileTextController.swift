//
//  inputProfileTextController.swift
//  PianistMatchingApp
//
//  Created by 仲優樹 on 2023/04/23.
//

import UIKit

class inputProfileTextController: UIViewController {

    @IBOutlet weak var profileTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Util.rectButton(button: doneButton)
        
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        let manager = Manager.shared
        print(manager.profile)
        manager.profile = profileTextView.text
        dismiss(animated: true, completion: nil)
        
    }
    
}
