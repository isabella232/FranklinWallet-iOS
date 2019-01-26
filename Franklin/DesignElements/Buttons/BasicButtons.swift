//
//  BasicSeletedButton.swift
//  DiveLane
//
//  Created by Anton Grigorev on 11/01/2019.
//  Copyright © 2019 Matter Inc. All rights reserved.
//

import UIKit

class BasicGreenButton: UIButton {
    
    let animation = AnimationController()
    
    override func awakeFromNib() {
        let height: CGFloat = Constants.buttons.heights.main
        let heightContraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        self.addConstraints([heightContraint])
        self.layer.cornerRadius = Constants.buttons.cornerRadius.main
        self.clipsToBounds = true
        let font = UIFont(name: Constants.regularFont, size: Constants.buttonFontSize)!
        self.titleLabel?.font = font
        self.backgroundColor = Colors.mainGreen
        self.setTitleColor(Colors.textWhite, for: .normal)
        self.layer.borderWidth = Constants.buttons.borderWidth.main
        //self.layer.borderColor = Colors.firstMain.cgColor
        self.addTarget(self, action: #selector(buttonTouchedDown(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchCancel)
        self.addTarget(self, action: #selector(buttonTouchedDown(_:)), for: .touchDragInside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchDragOutside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchUpOutside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let height: CGFloat = Constants.buttons.heights.main
        let heightContraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        let width: CGFloat = 0.8 * UIScreen.main.bounds.width
        let widthContraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: width)
        self.addConstraints([heightContraint, widthContraint])
        self.layer.cornerRadius = Constants.buttons.cornerRadius.main
        self.clipsToBounds = true
        let font = UIFont(name: Constants.regularFont, size: Constants.buttonFontSize)!
        self.titleLabel?.font = font
        self.backgroundColor = Colors.mainGreen
        self.setTitleColor(Colors.textWhite, for: .normal)
        self.layer.borderWidth = Constants.buttons.borderWidth.main
        //self.layer.borderColor = Colors.firstMain.cgColor
        self.addTarget(self, action: #selector(buttonTouchedDown(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchCancel)
        self.addTarget(self, action: #selector(buttonTouchedDown(_:)), for: .touchDragInside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchDragOutside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchUpOutside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTouchedDown(_ sender: UIButton) {
        animation.pressButtonStartedAnimation(for: sender, color: Colors.mainGreen)
    }
    
    @objc func buttonTouchedUp(_ sender: UIButton) {
        animation.pressButtonCanceledAnimation(for: sender, color: Colors.mainGreen)
    }
}

class BasicBlueButton: UIButton {
    
    let animation = AnimationController()
    
    override func awakeFromNib() {
        let height: CGFloat = Constants.buttons.heights.main
        let heightContraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        self.addConstraints([heightContraint])
        self.layer.cornerRadius = Constants.buttons.cornerRadius.main
        self.clipsToBounds = true
        let font = UIFont(name: Constants.regularFont, size: Constants.buttonFontSize)!
        self.titleLabel?.font = font
        self.backgroundColor = Colors.mainBlue
        self.setTitleColor(Colors.textWhite, for: .normal)
        self.layer.borderWidth = Constants.buttons.borderWidth.main
        //self.layer.borderColor = Colors.firstMain.cgColor
        self.addTarget(self, action: #selector(buttonTouchedDown(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchCancel)
        self.addTarget(self, action: #selector(buttonTouchedDown(_:)), for: .touchDragInside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchDragOutside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchUpOutside)
    }
    
    @objc func buttonTouchedDown(_ sender: UIButton) {
        animation.pressButtonStartedAnimation(for: sender, color: Colors.mainBlue)
    }
    
    @objc func buttonTouchedUp(_ sender: UIButton) {
        animation.pressButtonCanceledAnimation(for: sender, color: Colors.mainBlue)
    }
}

class BasicWhiteButton: UIButton {
    
    let animation = AnimationController()
    
    var currentBackgroundColor: UIColor?
    
    override func awakeFromNib() {
        let height: CGFloat = Constants.buttons.heights.main
        let heightContraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        self.addConstraints([heightContraint])
        self.layer.cornerRadius = Constants.buttons.cornerRadius.main
        self.clipsToBounds = true
        let font = UIFont(name: Constants.regularFont, size: Constants.buttonFontSize)!
        self.titleLabel?.font = font
        self.backgroundColor = Colors.textWhite
        self.setTitleColor(Colors.mainBlue, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.mainBlue.cgColor
        self.addTarget(self, action: #selector(buttonTouchedDown(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchCancel)
        self.addTarget(self, action: #selector(buttonTouchedDown(_:)), for: .touchDragInside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchDragOutside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchUpOutside)
    }
    
    func changeColorOn(background color: UIColor, text: UIColor) {
        self.backgroundColor = color
        self.setTitleColor(text, for: .normal)
        self.currentBackgroundColor = color
    }
    
    @objc func buttonTouchedDown(_ sender: UIButton) {
        animation.pressButtonStartedAnimation(for: sender, color: self.currentBackgroundColor!)
    }
    
    @objc func buttonTouchedUp(_ sender: UIButton) {
        animation.pressButtonCanceledAnimation(for: sender, color: self.currentBackgroundColor!)
    }
}

class BasicOrangeButton: UIButton {
    
    let animation = AnimationController()
    
    override func awakeFromNib() {
        let height: CGFloat = Constants.buttons.heights.main
        let heightContraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        self.addConstraints([heightContraint])
        self.layer.cornerRadius = Constants.buttons.cornerRadius.main
        self.clipsToBounds = true
        let font = UIFont(name: Constants.regularFont, size: Constants.buttonFontSize)!
        self.titleLabel?.font = font
        self.backgroundColor = Colors.orange
        self.setTitleColor(Colors.textWhite, for: .normal)
        self.layer.borderWidth = 0
        self.addTarget(self, action: #selector(buttonTouchedDown(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchCancel)
        self.addTarget(self, action: #selector(buttonTouchedDown(_:)), for: .touchDragInside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchDragOutside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchUpOutside)
    }
    
    @objc func buttonTouchedDown(_ sender: UIButton) {
        animation.pressButtonStartedAnimation(for: sender, color: Colors.orange)
    }
    
    @objc func buttonTouchedUp(_ sender: UIButton) {
        animation.pressButtonCanceledAnimation(for: sender, color: Colors.orange)
    }
}

class ScanButton: UIButton {
    
    let animation = AnimationController()
    
    override func awakeFromNib() {
        let height: CGFloat = Constants.buttons.heights.main
        let heightContraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        let width: CGFloat = Constants.buttons.heights.main
        let widthContraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: width)
        self.addConstraints([heightContraint, widthContraint])
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.backgroundColor = UIColor.white
        self.setBackgroundImage(UIImage(named: "photo"), for: .normal)
        self.addTarget(self, action: #selector(buttonTouchedDown(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchCancel)
        self.addTarget(self, action: #selector(buttonTouchedDown(_:)), for: .touchDragInside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchDragOutside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonTouchedUp(_:)), for: .touchUpOutside)
    }
    
    @objc func buttonTouchedDown(_ sender: UIButton) {
    }
    
    @objc func buttonTouchedUp(_ sender: UIButton) {
    }
}
