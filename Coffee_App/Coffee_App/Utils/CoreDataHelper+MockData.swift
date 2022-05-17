//
//  CoreDataHelper+MockData.swift
//  Coffee_App
//
//  Created by user219614 on 5/15/22.
//

import Foundation

extension CoreDataHelper {
    
    func genMockData() {
        let appLaunched = UserDefaults.standard.bool(forKey: "appLaunched")
        guard !appLaunched else { return }
        UserDefaults.standard.set(true, forKey: "appLaunched")
        
        // mock data
        self.genMockMenu()        
    }
    
    fileprivate func genMockMenu() {
        let coffees:[CoffeeModel] = [
            CoffeeModel(name: "Caffè Americano", price: 9.99, image: "Caffè Americano"),
            CoffeeModel(name: "Caffè Mocha", price: 9.99, image: "Caffè Mocha"),
            CoffeeModel(name: "Caramel Macchiato", price: 9.99, image: "Caramel Macchiato"),
            CoffeeModel(name: "Dark Chocolate Mocha", price: 9.99, image: "Dark Chocolate Mocha"),
            CoffeeModel(name: "Espresso Macchiato", price: 9.99, image: "Espresso Macchiato"),
            CoffeeModel(name: "White Chocolate Mocha", price: 9.99, image: "White Chocolate Mocha"),
        ]
        
        coffees.forEach { model in
            self.addMenu(model: model)
        }
    }
    
}
