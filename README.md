# PieChart

PieChart is a simple animated pie chart for iOS apps.

<a href="https://i.imgflip.com/3rlv61"><img src="https://i.imgflip.com/3rlv61.gif"></a>

## Usage

```Swift
// download the demo and import PieChartView.swift file to your project

  class ViewController: UIViewController {

    @IBOutlet private var chartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.chartView.addAnimation = false
        self.chartView.animationDuration = 1.0
        self.chartView.sperator = 3 / space between chart items
        
        self.chartView.drawChart([PieChartItem (UIColor.red, 10.0),
                                  PieChartItem (UIColor.green, 20.0),
                                  PieChartItem (UIColor.blue, 30.0),
                                  PieChartItem (UIColor.purple, 40.0)])
    }
  }
```

feel free to make a pull request and enhance
