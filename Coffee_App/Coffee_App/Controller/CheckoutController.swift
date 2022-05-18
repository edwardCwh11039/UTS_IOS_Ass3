//
//  ViewController.swift
//  Coffee_App
//
//  Created by user219614 on 5/6/22.
//

import UIKit
import Braintree
struct Item {
    let name: String?
    let quantity: Int?
    let eachPrice: Double?
}
class CheckoutController: UIViewController, UITableViewDataSource {
    var braintreeClient:BTAPIClient!
    var items = [CoffeeModel?]()
    var coffee: CoffeeModel?

    func setItems() -> [Item] {
        let items = [
            Item(name: "Cappuccino", quantity: 3, eachPrice: 4.4),
            Item(name: "Latte", quantity: 3, eachPrice: 4.4),
            Item(name: "Flat White", quantity: 3, eachPrice: 4.4),
            Item(name: "Long Black", quantity: 3, eachPrice: 4.4),
            Item(name: "Espresso", quantity: 3, eachPrice: 4.4),
        ]
        return items
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.braintreeClient = BTAPIClient(authorization: "sandbox_d5z6vxpn_6fwm99rqhtf44rf4")
        self.items.append(coffee)
        // Pay Now Button
        let button = UIButton(frame: CGRect(x: view.center.x - 150, y: self.view.frame.size.height, width: 300, height: 50))
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.setTitle("Pay Now", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        //custom icon + label
        let label = UIStackView()
        label.spacing = 0
        label.axis = NSLayoutConstraint.Axis.vertical
        label.alignment = UIStackView.Alignment.center
        
        //Checkout Icon
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        imageView.image = UIImage(named: "cart")

        //Text Label
        let textLabel = UILabel()
        textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        textLabel.text  = "Checkout"
        textLabel.textAlignment = .center
        
        //order summary table view
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(CheckoutTableCell.self, forCellReuseIdentifier: "cell")

        //Stack View
        let stackView   = UIStackView(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height - (self.tabBarController?.tabBar.frame.size.height ?? 50) - (UIApplication.shared.windows.first?.safeAreaInsets.top)!) )
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 10.0

        label.addArrangedSubview(imageView)
        label.addArrangedSubview(textLabel)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(button)

        self.view.addSubview(stackView)
        
        tableView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        let payPalDriver = BTPayPalDriver(apiClient: self.braintreeClient)
        
        // Specify the transaction amount here. "2.32" is used in this example.
        let request = BTPayPalCheckoutRequest(amount: "2.32")
        request.currencyCode = "USD" // Optional; see BTPayPalCheckoutRequest.h for more options
        
        payPalDriver.tokenizePayPalAccount(with: request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                
                if let finishVC = ControllerFactory.createFinishViewController() {
                    finishVC.coffee = self.coffee
                    finishVC.modalPresentationStyle = .fullScreen
                    finishVC.modalTransitionStyle = .crossDissolve
                    self.present(finishVC, animated: true)
                }
            } else if let error = error {
                // Handle error here...
                print(error)
            } else {
                // Buyer canceled payment approval
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CheckoutTableCell
        cell.itemName.text = items[indexPath.row]?.name
        cell.itemQuantity.text = "x\(items[indexPath.row]?.quanity ?? 1)"
        cell.itemPrices.text = String(format: "%.2f",(Double(items[indexPath.row]!.quanity) * items[indexPath.row]!.price))
        return cell
    }
}

