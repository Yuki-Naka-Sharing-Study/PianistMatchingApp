//
//  ProfileTextCell.swift
//  PianistMatchingApp
//
//  Created by 仲優樹 on 2023/04/26.
//

import UIKit

class ProfileTextCell: UITableViewCell {
    
    @IBOutlet weak var profileTextView: UITextView!
    
    static let identifier = "ProfileTextCell"
    
    static func nib()->UINib{
        
        return UINib(nibName: "ProfileTextCell", bundle: nil)
        
    }
    
    func configure(profileTextViewString:String) {
        
        profileTextView.text = profileTextViewString
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
