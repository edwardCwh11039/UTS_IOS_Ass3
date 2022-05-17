//
//  MenuPopViewController.swift
//  Coffee_App
//
//  Created by user219614 on 5/15/22.
//

import UIKit

protocol MenuPopViewControllerDelegate: AnyObject {
    func didBuy(coffee: CoffeeModel)
    func didCancelBuy()
}

class MenuPopViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quanitityStepper: UIStepper!
    @IBOutlet weak var cupSizeSegment: UISegmentedControl!
    @IBOutlet weak var espressoSegment: UISegmentedControl!
    @IBOutlet weak var milkSegment: UISegmentedControl!
    @IBOutlet weak var temperatureSegment: UISegmentedControl!
    @IBOutlet weak var syrupLabel: UILabel!
    @IBOutlet weak var syrupStepper: UIStepper!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    var coffee: CoffeeModel? {
        didSet {
            if self.isViewLoaded {
                self.updateUI()
            }
        }
    }
    weak var delegate: MenuPopViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.containerView.layer.cornerRadius = 8
        self.containerView.clipsToBounds = true
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        self.updateUI()
    }
    
    @IBAction func onTapBg(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
        self.delegate?.didCancelBuy()
    }
    
    @IBAction func onBuy(_ sender: Any) {
        if let coffee = self.coffee {
            self.delegate?.didBuy(coffee: coffee)
        }
    }
    
    @IBAction func onQuanityChanged(_ sender: Any) {
        self.updateModel()
    }
    
    @IBAction func onCupSizeChanged(_ sender: Any) {
        self.updateModel()
    }
    
    @IBAction func onEspressoChanged(_ sender: Any) {
        self.updateModel()
    }
    
    @IBAction func onMilkChanged(_ sender: Any) {
        self.updateModel()
    }
    
    @IBAction func onTemperatureChanged(_ sender: Any) {
        self.updateModel()
    }
    
    @IBAction func onSyrupChanged(_ sender: Any) {
        self.updateModel()
    }
    
    fileprivate func updateUI() {
        guard let model = coffee else { return }
        
        self.quanitityStepper.value = Double(model.quanity)
        self.quantityLabel.text = "\(model.quanity)"
        self.cupSizeSegment.selectedSegmentIndex = model.cupSize.rawValue
        self.espressoSegment.selectedSegmentIndex = model.espresso.rawValue
        self.milkSegment.selectedSegmentIndex = model.milk.rawValue
        self.temperatureSegment.selectedSegmentIndex = model.temperature.rawValue
        self.syrupStepper.value = Double(model.syrup)
        self.syrupLabel.text = "\(model.syrup) Pump(s)"
    }
    
    fileprivate func updateModel() {
        var model = self.coffee
        model?.quanity = Int(self.quanitityStepper.value)
        
        let cupSize: Int = self.cupSizeSegment.selectedSegmentIndex
        model?.cupSize = CoffeeModel.CupSize(rawValue: cupSize) ?? .tall
        
        let espresso: Int = self.espressoSegment.selectedSegmentIndex
        model?.espresso = CoffeeModel.Espresso(rawValue: espresso) ?? .standard
        
        let milk: Int = self.milkSegment.selectedSegmentIndex
        model?.milk = CoffeeModel.Milk(rawValue: milk) ?? .oat
        
        let temperature: Int = self.temperatureSegment.selectedSegmentIndex
        model?.temperature = CoffeeModel.Temperature(rawValue: temperature) ?? .hot
        
        model?.syrup = Int(self.syrupStepper.value)
        
        self.coffee = model
    }
}
