//
//  BookTableViewCell.swift
//  Library of Alexandria
//
//  Created by Jenna on 5/4/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
