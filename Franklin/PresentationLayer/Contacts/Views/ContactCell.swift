//
//  ContactCell.swift
//  Franklin
//
//  Created by Anton Grigorev on 23/01/2019.
//  Copyright © 2019 Matter Inc. All rights reserved.
//

import UIKit

class ContactCell: UICollectionViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with contact: Contact) {
        self.name.text = contact.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.name.text = ""
    }

}
