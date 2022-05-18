//
//  CheckoutTableCell.swift
//  Coffee_App
//
//  Created by user219614 on 5/17/22.
//

import UIKit

class CheckoutTableCell: UITableViewCell {

    let itemName = UILabel()
    let itemQuantity = UILabel()
    let itemPrices = UILabel()
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemQuantity.translatesAutoresizingMaskIntoConstraints = false
        itemPrices.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(itemName)
        contentView.addSubview(itemQuantity)
        contentView.addSubview(itemPrices)
        
        let viewDict = [
            "name": itemName,
            "quantity": itemQuantity,
            "price": itemPrices,
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[name]-[quantity]-[price]-|", options: [], metrics: nil, views: viewDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name]-|", options: [], metrics: nil, views: viewDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[quantity]-|", options: [], metrics: nil, views: viewDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[price]-|", options: [], metrics: nil, views: viewDict))
    }
    
    required init?(coder: NSCoder){
        fatalError("Init(coder:) has not been implemented")
    }
    

}
