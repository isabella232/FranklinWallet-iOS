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
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0.8 * UIScreen.main.bounds.width, height: Constants.buttons.heights.main))
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
        let font = UIFont(name: Constants.boldFont, size: Constants.buttonFontSize) ?? UIFont.boldSystemFont(ofSize: Constants.buttonFontSize)
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
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0.8 * UIScreen.main.bounds.width, height: Constants.buttons.heights.main))
    }
    
    @objc func buttonTouchedDown(_ sender: UIButton) {
        animation.pressButtonStartedAnimation(for: sender)
    }
    
    @objc func buttonTouchedUp(_ sender: UIButton) {
        animation.pressButtonCanceledAnimation(for: sender)
    }
}

class BasicBlueButton: UIButton {
    
    let animation = AnimationController()
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0.8 * UIScreen.main.bounds.width, height: Constants.buttons.heights.main))
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
        let font = UIFont(name: Constants.boldFont, size: Constants.buttonFontSize) ?? UIFont.boldSystemFont(ofSize: Constants.buttonFontSize)
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
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0.8 * UIScreen.main.bounds.width, height: Constants.buttons.heights.main))
    }
    
    @objc func buttonTouchedDown(_ sender: UIButton) {
        animation.pressButtonStartedAnimation(for: sender)
    }
    
    @objc func buttonTouchedUp(_ sender: UIButton) {
        animation.pressButtonCanceledAnimation(for: sender)
    }
}

class ScanButton: UIButton {
    
    let animation = AnimationController()
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: Constants.buttons.heights.main, height: Constants.buttons.heights.main))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0.8 * UIScreen.main.bounds.width, height: Constants.buttons.heights.main))
    }
    
    @objc func buttonTouchedDown(_ sender: UIButton) {
        animation.pressButtonStartedAnimation(for: sender)
    }
    
    @objc func buttonTouchedUp(_ sender: UIButton) {
        animation.pressButtonCanceledAnimation(for: sender)
    }
}
