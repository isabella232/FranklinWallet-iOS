//
//  OnboardingViewController.swift
//  DiveLane
//
//  Created by Anton Grigorev on 08/09/2018.
//  Copyright © 2018 Matter Inc. All rights reserved.
//

import UIKit

class OnboardingViewController: BasicViewController {
    
//    let nextBtn = UIButton(frame: CGRect(x: 0, y: 0, width: Constants.buttons.widths.onboarding, height: Constants.buttons.heights.onboarding))
//    let skipBtn = UIButton(frame: CGRect(x: 0, y: 0, width: Constants.buttons.widths.onboarding, height: Constants.buttons.heights.onboarding))
    
    private let userDefaults = UserDefaultKeys()

    var pageViewController: UIPageViewController!
    let continueButton = BasicGreenButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
        self.navigationController?.navigationBar.isHidden = true
        createPages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1) {
            self.view.alpha = 1
        }
    }
    
    func title() -> UILabel {
        let width = UIScreen.main.bounds.width
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: width*0.8, height: 70))
        title.textAlignment = .center
        title.text = "FRANKLIN"
        title.textColor = Colors.textDarkGray
        title.font = UIFont(name: Constants.boldFont, size: 55) ?? UIFont.boldSystemFont(ofSize: 55)
        return title
    }
    
    func subtitle() -> UILabel {
        let width = UIScreen.main.bounds.width
        let subtitle = UILabel(frame: CGRect(x: 0, y: 0, width: width*0.8, height: 30))
        subtitle.textAlignment = .center
        subtitle.text = "SECURE DOLLAR WALLET"
        subtitle.textColor = Colors.textDarkGray
        subtitle.font = UIFont(name: Constants.font, size: 22) ?? UIFont.systemFont(ofSize: 22)
        return subtitle
    }
    
    func bottomInfo() -> UILabel {
        let width = UIScreen.main.bounds.width
        let info = UILabel(frame: CGRect(x: 0, y: 0, width: width*0.8, height: 40))
        info.textAlignment = .center
        info.text = "By clicking 'Continue' you agree to the"
        info.textColor = Colors.textBlack
        info.font = UIFont(name: Constants.font, size: 16) ?? UIFont.systemFont(ofSize: 16)
        return info
    }
    
    func link() -> UIButton {
        let width = UIScreen.main.bounds.width
        let info = UIButton(frame: CGRect(x: 0, y: 0, width: width*0.8, height: 40))
        let attrs = [
            NSAttributedString.Key.font : UIFont(name: Constants.font, size: 16) ?? UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : Colors.mainGreen,
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        let buttonTitleString = NSAttributedString(string: "terms and conditions", attributes: attrs)
        info.setAttributedTitle(buttonTitleString, for: .normal)
        return info
    }
    
    func createPages() {
        let pc = UIPageControl.appearance()
        pc.pageIndicatorTintColor = Colors.background
        pc.currentPageIndicatorTintColor = Colors.background
//        pc.pageIndicatorTintColor = Colors.otherLightGray
//        pc.currentPageIndicatorTintColor = Colors.otherDarkGray
        pc.backgroundColor = Colors.background
        
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 0.8 * UIScreen.main.bounds.width, height: 100))
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "franklin")!
        
        let _title = self.title()
        let _subtitle = self.subtitle()
        let _bottomInfo = self.bottomInfo()
        let _link = self.link()
        
        self.pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                       navigationOrientation: .horizontal,
                                                       options: nil)
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        self.pageViewController.setViewControllers([self.viewControllerAtIndex(index: 0)],
                                                   direction: .forward,
                                                   animated: true,
                                                   completion: nil)
        self.addChild(self.pageViewController)
        
        self.continueButton.addTarget(self,
                                      action: #selector(continueAction(sender:)),
                                      for: .touchUpInside)
        self.continueButton.setTitle("Continue", for: .normal)
        
        _link.addTarget(self, action: #selector(readTerms(sender:)), for: .touchUpInside)
        
        let views = [
            "title": _title,
            "subtitle": _subtitle,
            "iv": iv,
            "continue": self.continueButton,
            "bottomInfo": _bottomInfo,
            "link": _link
        ]
        
        for (_, v) in views {
            v.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(v)
        }
        
        var constraints = [NSLayoutConstraint(
            item: self.continueButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)]
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-[title]-|",
                                                          options: .alignAllCenterX,
                                                          metrics: [:],
                                                          views: views as [String : Any]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-[subtitle]-|",
                                                          options: .alignAllCenterX,
                                                          metrics: [:],
                                                          views: views as [String : Any]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[iv]|",
                                                          options: .alignAllCenterX,
                                                          metrics: [:],
                                                          views: views as [String : Any]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomInfo]|",
                                                          options: .alignAllCenterX,
                                                          metrics: [:],
                                                          views: views as [String : Any]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[link]|",
                                                          options: .alignAllCenterX,
                                                          metrics: [:],
                                                          views: views as [String : Any]))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[title]-[subtitle]-[iv]-30-[continue]-20-[bottomInfo(20)]-10-[link(20)]-50-|",
                                                                      options: .alignAllCenterX,
                                                                      metrics: [:],
                                                                      views: views as [String : Any]))
        NSLayoutConstraint.activate(constraints)
        
        self.pageViewController.didMove(toParent: self)
    }

//    func createPages() {
//
//        let pc = UIPageControl.appearance()
//        pc.pageIndicatorTintColor = Colors.active
//        pc.currentPageIndicatorTintColor = Colors.secondMain
//        pc.backgroundColor = Colors.firstMain
//
//        self.pageViewController = UIPageViewController(transitionStyle: .scroll,
//                navigationOrientation: .horizontal,
//                options: nil)
//        self.pageViewController.dataSource = self
//        self.pageViewController.delegate = self
//        self.pageViewController.setViewControllers([self.viewControllerAtIndex(index: 0)],
//                direction: .forward,
//                animated: true,
//                completion: nil)
//        self.addChild(self.pageViewController)
//
//        self.nextBtn.addTarget(self,
//                action: #selector(onboardingAction(sender:)),
//                for: .touchUpInside)
//        self.nextBtn.setTitle("NEXT", for: .normal)
//        self.nextBtn.backgroundColor = Colors.firstMain
//        self.nextBtn.setTitleColor(Colors.secondMain, for: .normal)
//        self.nextBtn.layer.cornerRadius = Constants.buttons.heights.onboarding / 2
//
//        self.skipBtn.addTarget(self,
//                               action: #selector(skipAction(sender:)),
//                               for: .touchUpInside)
//        self.skipBtn.setTitle("SKIP", for: .normal)
//        self.skipBtn.backgroundColor = Colors.secondMain
//        self.skipBtn.setTitleColor(Colors.active, for: .normal)
//        self.skipBtn.layer.cornerRadius = Constants.buttons.heights.onboarding / 2
//
//        let views = [
//            "pg": self.pageViewController.view,
//            "next": nextBtn,
//            "skip": skipBtn
//        ]
//        for (_, v) in views {
//            v?.translatesAutoresizingMaskIntoConstraints = false
//            self.view.addSubview(v!)
//        }
//
//        NSLayoutConstraint.activate(
//                [NSLayoutConstraint(
//                                    item: self.nextBtn,
//                                    attribute: .centerX,
//                                    relatedBy: .equal,
//                                    toItem: self.view,
//                                    attribute: .centerX,
//                                    multiplier: 1,
//                                    constant: 0)
//                ] +
//                [NSLayoutConstraint(
//                                    item: self.skipBtn,
//                                    attribute: .centerX,
//                                    relatedBy: .equal,
//                                    toItem: self.view,
//                                    attribute: .centerX,
//                                    multiplier: 1,
//                                    constant: 0)
//                ] +
//                NSLayoutConstraint.constraints(withVisualFormat: "H:|[pg]|",
//                                               options: .alignAllCenterX,
//                                               metrics: [:],
//                                               views: views as [String : Any]) +
//                NSLayoutConstraint.constraints(withVisualFormat: "H:|-[next(120)]-|",
//                                               options: .alignAllCenterX,
//                                               metrics: [:],
//                                               views: views as [String : Any]) +
//                NSLayoutConstraint.constraints(withVisualFormat: "H:|-[skip(120)]-|",
//                                               options: .alignAllCenterX,
//                                               metrics: [:],
//                                               views: views as [String : Any]) +
//                NSLayoutConstraint.constraints(withVisualFormat: "V:|-[pg]-30-[next]-30-[skip]-105-|",
//                                               options: .alignAllCenterX,
//                                               metrics: [:],
//                                               views: views as [String : Any])
//        )
//
//        self.pageViewController.didMove(toParent: self)
//    }

//    @objc func onboardingAction(sender: UIButton) {
//        if let vc = pageViewController.viewControllers?.first as? OnboardingContentViewController {
//            switch vc.pageIndex {
//            case 2:
//                goToPincode()
//            default:
//                let index = vc.pageIndex + 1
//                changeOnboardingButtonStatus(for: index)
//                self.pageViewController.setViewControllers([self.viewControllerAtIndex(index: index)],
//                        direction: .forward,
//                        animated: true,
//                        completion: nil)
//            }
//        }
//
//    }

//    func goToPincode() {
//        userDefaults.setOnboardingPassed()
//        let vc = AppController().createPincodeController()
//        vc.view.backgroundColor = Colors.firstMain
//        self.present(vc, animated: true, completion: nil)
//    }
//
//    @objc func skipAction(sender: UIButton) {
//        goToPincode()
//    }
    
    @objc func continueAction(sender: UIButton) {
        let vc = AppController().walletCreationVC()
        vc.view.backgroundColor = Colors.background
        let transition = CATransition()
        transition.duration = 0.7
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(vc, animated: false, completion: nil)
    }
    
    @objc func readTerms(sender: UIButton) {
        print("Need to open terms")
    }

    func viewControllerAtIndex(index: Int) -> OnboardingContentViewController {
        if (PAGES.count == 0) || (index >= PAGES.count) {
            return OnboardingContentViewController()
        }
        let vc = OnboardingContentViewController()
        vc.pageIndex = index
        return vc
    }
//
//    func changeOnboardingButtonStatus(for page: Int) {
//        switch page {
//        case 2:
//            //self.nextBtn.setTitle("LETS GO!", for: .normal)
//            self.skipBtn.isHidden = true
//        default:
//            self.skipBtn.isHidden = false
//            //self.nextBtn.setTitle("NEXT", for: .normal)
//        }
//    }

}

extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = (viewController as? OnboardingContentViewController)!
        var index = vc.pageIndex as Int
        if index == 0 || index == NSNotFound {
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = (viewController as? OnboardingContentViewController)!
        var index = vc.pageIndex as Int
        if index == NSNotFound {
            return nil
        }
        index += 1
        if index == PAGES.count {
            return nil
        }
        return self.viewControllerAtIndex(index: index)
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let vc = pageViewController.viewControllers?.first as? OnboardingContentViewController else {
            return 0
        }
        //changeOnboardingButtonTitle(for: vc.pageIndex)
        return vc.pageIndex

    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return PAGES.count
    }

//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        if let vc = pageViewController.viewControllers?.first as? OnboardingContentViewController {
//            changeOnboardingButtonStatus(for: vc.pageIndex)
//        }
//    }

}
