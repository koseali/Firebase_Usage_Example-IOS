//
//  FeedTableViewCell.swift
//  Instagram_Basic_Clone
//
//  Created by Ali Köse on 10.12.2020.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var lbComment: UILabel!
    @IBOutlet weak var lbMail: UILabel!
    @IBOutlet weak var lbLike: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }
    @IBAction func likeButtonClick(_ sender: Any) {
    }
    
}
