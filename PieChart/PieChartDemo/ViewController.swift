//
//  ViewController.swift
//  PieChartDemo
//
//  Created by Michele on 3/4/20.
//  Copyright © 2020 Michelle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var chartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.chartView.addAnimation = true
        self.chartView.animationDuration = 1.0
        self.chartView.sperator = 3
        
        self.chartView.drawChart([PieChartItem (UIColor.red, 10.0),
                                  PieChartItem (UIColor.green, 20.0),
                                  PieChartItem (UIColor.blue, 30.0),
                                  PieChartItem (UIColor.purple, 40.0)])
    }
}
