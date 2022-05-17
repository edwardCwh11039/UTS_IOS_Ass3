//
//  CoffeeModel.swift
//  Coffee_App
//
//  Created by user219614 on 5/15/22.
//

import Foundation

struct CoffeeModel {
    
    enum CupSize: Int, CaseIterable {
        case tall
        case grande
        case venti
    }
    
    enum Espresso: Int, CaseIterable {
        case standard
        case ristretto
        case longShot
    }
    
    enum Milk: Int, CaseIterable {
        case whole
        case oat
        case skim
    }
    
    enum Temperature: Int, CaseIterable {
        case hot
        case iced
    }
    
    var name: String
    var price: Double
    var image: String
    
    var cupSize: CupSize = .grande
    var espresso: Espresso = .standard
    var milk: Milk = .whole
    var temperature: Temperature = .hot
    var syrup: Int = 0
    var quanity: Int = 1
    
//    init(name: String, price: Double, image: String) {
//        self.name = name
//        self.price = price
//        self.image = image
//    }
}

extension CoffeeModel.CupSize {
    var itemTitle: String {
        switch self {
        case .tall:
            return "Tall"
        case .grande:
            return "Grande"
        case .venti:
            return "Venti"
        }
    }
}

extension CoffeeModel.Espresso {
    var itemTitle: String {
        switch self {
        case .standard:
            return "Standard"
        case .ristretto:
            return "Ristretto"
        case .longShot:
            return "Long shot"
        }
    }
}

extension CoffeeModel.Milk {
    var itemTitle: String {
        switch self {
        case .oat:
            return "Oat milk"
        case .whole:
            return "Whole milk"
        case .skim:
            return "Skim milk"
        }
    }
}

extension CoffeeModel.Temperature {
    var itemTitle: String {
        switch self {
        case .hot:
            return "Hot"
        case .iced:
            return "Iced"
        }
    }
}

