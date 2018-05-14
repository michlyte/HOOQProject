//
//  MovieTableViewCell.swift
//  HOOQProject
//
//  Created by Michael Halim on 12/05/18.
//  Copyright © 2018 com. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = ColorUtil.black
        
        titleLabel.textColor = ColorUtil.red
        scoreLabel.textColor = ColorUtil.white
        overviewLabel.textColor = ColorUtil.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
