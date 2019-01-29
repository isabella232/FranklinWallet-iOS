//
//  BasicTextField.swift
//  Franklin
//
//  Created by Anton Grigorev on 24/01/2019.
//  Copyright © 2019 Matter Inc. All rights reserved.
//

import UIKit

class BasicTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = Constants.cornerRadius
        self.clipsToBounds = true
        self.backgroundColor = Colors.background
        self.textColor = Colors.mainBlue
        self.layer.borderWidth = 2
        self.layer.borderColor = Colors.mostLightGray.cgColor
        self.textAlignment = .left
        self.font = UIFont(name: Constants.regularFont, size: Constants.textFieldFontSize) ?? UIFont.systemFont(ofSize: Constants.textFieldFontSize)
    }
}
