//
//  MapViewController.swift
//  Coffee_App
//
//  Created by user219614 on 5/15/22.
//

import UIKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMenu(_ sender: Any) {
        
        if let menuVC = ControllerFactory.createMenuViewController() {
            let nav = UINavigationController(rootViewController: menuVC)
            
            nav.modalPresentationStyle = .fullScreen
            //nav.modalTransitionStyle = .crossDissolve
            self.present(nav, animated: true)
        }
    }

}
