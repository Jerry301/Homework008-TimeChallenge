//
//  ViewController.swift
//  Homework008
//
//  Created by Chun-Yi Lin on 2021/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var dateSlider: UISlider!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let dateFormatter = DateFormatter()
    var timer : Timer?
    var sliderValue = 0
    var startYear = 2012
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func pickDateSlider(_ sender: UISlider) {
        sender.value = sender.value.rounded()
        sliderValue = Int(sender.value)
        yearLabel.text = "\(sliderValue)"
        showImageView.image = UIImage(named: "\(sliderValue)")
        let yearDate = String(sliderValue)
        dateFormatter.dateFormat = "yyyy"
        let selectedYear = dateFormatter.date(from: yearDate)
        if let selectedYear = selectedYear {
            datePicker.date = selectedYear
        }
    }
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let pickedYear = sender.date
        dateFormatter.dateFormat = "yyyy"
        let yearDate = dateFormatter.string(from: pickedYear)
        let selectedYear = Float(yearDate)
        yearLabel.text = "\(yearDate)"
        if let selectedYear = selectedYear {
            dateSlider.value = selectedYear
        }
        showImageView.image = UIImage(named: yearDate)
    }
    
    @IBAction func autoDateChangeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            datePicker.isEnabled = false
            dateSlider.isEnabled = false
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ [self] timer in
                self.yearLabel.text = "\(startYear)"
                self.showImageView.image = UIImage(named: "\(self.startYear)")
                self.dateSlider.value = Float(self.startYear)
                let yearDate = String(startYear)
                dateFormatter.dateFormat = "yyyy"
                let selectedYear = dateFormatter.date(from: yearDate)
                if let selectedYear = selectedYear {
                    datePicker.date = selectedYear
                }
                if startYear <= 2020 {
                    self.startYear += 1
                }
            }
        }else {
            datePicker.isEnabled = true
            dateSlider.isEnabled = true
            startYear = 2012
            timer?.invalidate()
        }
        
    }
    
}

