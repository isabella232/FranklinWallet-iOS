//
//  AnimationController.swift
//  DiveLane
//
//  Created by Anton Grigorev on 12/09/2018.
//  Copyright © 2018 Matter Inc. All rights reserved.
//

import UIKit

final class AnimationController {
    
    func pressButtonStartedAnimation(for sender: UIButton) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.05,
                           animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                           completion: nil)
        }
    }
    
    func pressButtonCanceledAnimation(for sender: UIButton) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.05) {
                sender.transform = CGAffineTransform.identity
            }
        }
    }
    
    func makeMoveUpWithBounce(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double, cell: UITableViewCell) {
        cell.transform = CGAffineTransform(translationX: 0, y: 100)
        
        UIView.animate(
            withDuration: duration,
            delay: delayFactor,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.9,
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
}
