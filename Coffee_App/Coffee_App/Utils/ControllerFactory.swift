//
//  ControllerFactory.swift
//  Coffee_App
//
//  Created by user219614 on 5/15/22.
//

import Foundation
import UIKit

class ControllerFactory {
    
    private static var storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    static func createMenuViewController() -> MenuViewController? {
        return storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
    }
    
    static func createMenuPopViewController() -> MenuPopViewController? {
        return storyboard.instantiateViewController(withIdentifier: "MenuPopViewController") as? MenuPopViewController
    }
    
    static func createFinishViewController() -> FinishViewController? {
        return storyboard.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController
    }
}
