//
//  Constants.swift
//  DiveLane
//
//  Created by Anton Grigorev on 25.09.2018.
//  Copyright © 2018 Matter Inc. All rights reserved.
//

import UIKit

public struct Constants {
    
    static let widthCoef: CGFloat = 0.9
    static let horizontalConst: CGFloat = 20
    static let cornerRadius: CGFloat = 10
    static let franklinSemiboldFont: String = "LibreFranklin-Semibold"
    static let franklinMediumFont: String = "LibreFranklin-Medium"
    static let regularFont: String = "SFProText-Regular"
    static let boldFont: String = "SFProText-Bold"
    static let semiboldFont: String = "SFProText-Semibold"
    static let mediumFont: String = "SFProText-Medium"
    static let lightFont: String = "SFProText-Light"
    static let heavyFont: String = "SFProText-Heavy"
    static let buttonFontSize: CGFloat = 26
    
    static let basicFontSize: CGFloat = 18
    static let smallFontSize: CGFloat = 14
    
    static let newWalletPassword = "Matter"
    static let newWalletName = "ETH Wallet"
    
    public struct textViews {
        public struct heights {
            static let main: CGFloat = 90
        }
    }
    public struct buttons {
        public struct borderWidth {
            static let main: CGFloat = 0
        }
        public struct cornerRadius {
            static let main: CGFloat = 8
        }
        public struct heights {
            static let main: CGFloat = 60
        }
        public struct widths {
            static let onboarding: CGFloat = 300
        }
    }
    public struct rows {
        public struct heights {
            static let settings: CGFloat = 45
            static let contacts: CGFloat = 120
            static let networks: CGFloat = 120
            static let wallets: CGFloat = 120
            static let tokens: CGFloat = 270
            static let additionalButtons: CGFloat = 40
        }
    }
    public struct headers {
        public struct heights {
            static let wallets: CGFloat = 30
            static let tokens: CGFloat = 30
        }
    }
    public struct segmentedControlls {
        public struct heights {
            static let wallets: CGFloat = 30
        }
    }
}
