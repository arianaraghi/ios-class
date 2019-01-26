//
//  LevelTableViewCell.swift
//  AmGhezi
//
//  Created by Aria on 10/24/18.
//  Copyright © 2018 Aria. All rights reserved.
//

import UIKit

class LevelTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var levelName: UILabel!
    @IBOutlet weak var hardness: UILabel!
    @IBOutlet weak var level: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
