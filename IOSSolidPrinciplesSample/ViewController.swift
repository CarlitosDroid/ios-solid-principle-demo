//
//  ViewController.swift
//  IOSSolidPrinciplesSample
//
//  Created by Carlos Leonardo Camilo Vargas Huamán on 3/3/19.
//  Copyright © 2019 Carlos Leonardo Camilo Vargas Huamán. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let service = Service(appDelegate: appDelegate)
        
        let product = Product(id: 1, name: "Product One", price: 10.0)
        
        print("Product price: \(service.calculateProductTax(product: product))")
        
        _ = service.saveProduct(product: product)
        
        let products = service.getListProducts()
        for product in products {
            print("Current product \(product)")
        }
    }
}
