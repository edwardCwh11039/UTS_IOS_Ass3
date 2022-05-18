//
//  FinishViewController.swift
//  Coffee_App
//
//  Created by user219614 on 5/15/22.
//

import UIKit

class FinishViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coffeeImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    var coffee: CoffeeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.coffeeImage.layer.cornerRadius = UIScreen.main.bounds.width * 0.75 * 0.5
        self.coffeeImage.clipsToBounds = true
        self.nameLabel.text = nil
        self.descLabel.text = nil

        self.updateModel()
    }
    
    @IBAction func onBackToMain(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func updateModel() {
        guard let coffee = self.coffee else { return }
        
        self.nameLabel.text = coffee.name
        self.coffeeImage.image = UIImage(named: coffee.image)
        
        var descItems: [String] = []
        descItems.append("x\(coffee.quanity) Cup(s)")
        descItems.append(coffee.cupSize.itemTitle)
        descItems.append(coffee.espresso.itemTitle)
        descItems.append(coffee.milk.itemTitle)
        descItems.append(coffee.temperature.itemTitle)
        if coffee.syrup > 0 {
            descItems.append("x\(coffee.syrup) Pump(s) Syrup")
        }
        
        self.descLabel.text = descItems.joined(separator: " / ")
    }
}
