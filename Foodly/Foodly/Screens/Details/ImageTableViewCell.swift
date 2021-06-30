//
//  ImageTableViewCell.swift
//  Foodly
//
//  Created by mac on 09/06/2021.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var largeLabel: UILabel!
    @IBOutlet var smallLabel: UILabel!
    
    static let identifier = "ImageTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageTableViewCell", bundle: nil)
    }
    
    public func configure(with model: DetailModel) {
        myImageView.image = UIImage(named: model.image)
        largeLabel.text = model.title
        smallLabel.text = model.type
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
