//
//  MenuViewController.swift
//  Coffee_App
//
//  Created by user219614 on 5/15/22.
//

import UIKit
import CoreData
import SwiftUI

class MenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var models: [CoffeeMenu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Menu"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBack(_:)))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.models = CoreDataHelper.shared.getAllMenus()
    }
    
    @objc func onBack(_ sender: Any?) {
        self.dismiss(animated: true)
    }
    
    // Get the context of core data.
    fileprivate func getContext() -> NSManagedObjectContext{
        return CoreDataHelper.shared.getContext()
    }
    
    fileprivate func showMenuPopPage(menu: CoffeeMenu) {
        if let menuPopVC = ControllerFactory.createMenuPopViewController() {
            let coffeeModel = CoffeeModel(name: menu.name!, price: menu.price, image: menu.image!)
            menuPopVC.coffee = coffeeModel
            menuPopVC.modalPresentationStyle = .overFullScreen
            menuPopVC.modalTransitionStyle = .crossDissolve
            menuPopVC.delegate = self
            self.present(menuPopVC, animated: true)
        }
    }
    
    fileprivate func showFinishPage(coffee: CoffeeModel) {
        if let finishVC = ControllerFactory.createFinishViewController() {
            finishVC.coffee = coffee
            finishVC.modalPresentationStyle = .fullScreen
            finishVC.modalTransitionStyle = .crossDissolve
            self.present(finishVC, animated: true)
        }
    }
    
    fileprivate func showPaymentPage(coffee: CoffeeModel) {
        // TODO: payment page
        if let checkoutVC = ControllerFactory.createCheckoutViewController() {
            checkoutVC.coffee = coffee
            checkoutVC.modalPresentationStyle = .fullScreen
            checkoutVC.modalTransitionStyle = .crossDissolve
            self.present(checkoutVC, animated: true)
        }
        self.showFinishPage(coffee: coffee)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell",
                                                                         for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        
        let cellModel = self.models[indexPath.row]
        cell.update(menu: cellModel)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
}

extension MenuViewController: MenuTableViewCellDelegate {
    func didAdd(cell: MenuTableViewCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            
            let cellModel = self.models[indexPath.row]
            self.showMenuPopPage(menu: cellModel)
        }
    }
}

extension MenuViewController: MenuPopViewControllerDelegate {
    func didCancelBuy() {
        self.presentedViewController?.dismiss(animated: true)
    }
    
    func didBuy(coffee: CoffeeModel) {
        self.presentedViewController?.dismiss(animated: false)
        self.showPaymentPage(coffee: coffee)
    }
}
