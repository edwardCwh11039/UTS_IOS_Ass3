//
//  MenuTableViewCell.swift
//  Coffee_App
//
//  Created by user219614 on 5/15/22.
//

import UIKit

protocol MenuTableViewCellDelegate: AnyObject {
    func didAdd(cell: MenuTableViewCell)
}

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var coffeeImage: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    weak var delegate: MenuTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.coffeeImage.layer.cornerRadius = self.coffeeImage.frame.width / 2
        self.coffeeImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onAdd(_ sender: Any) {
        self.delegate?.didAdd(cell: self)
    }
    
    func update(menu: CoffeeMenu) {
        self.coffeeImage?.image = UIImage(named: menu.image!)
        self.nameLabel.text = menu.name
        self.descLabel.text = "$ \(menu.price)"
    }
}
