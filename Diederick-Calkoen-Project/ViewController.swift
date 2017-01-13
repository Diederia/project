//
//  ViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 10/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    
    let white = UIColor(colorWithHexValue: 0xECEAED)
    let black = UIColor(colorWithHexValue: 0x000000)
    let grey = UIColor(colorWithHexValue: 0x9f9999)
    let formatter = DateFormatter()
    let testCalendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateFormat = "yyyy MM dd"
//        testCalendar.timeZone = NSTimeZone(abbreviation: "DST")! as TimeZone

        
        calendarView.dataSource = self
        calendarView.delegate = self
        
        calendarView.registerCellViewXib(file: "CellView") // Registering your cell is manditory
        calendarView.cellInset = CGPoint(x: 3, y: 3)       // default is (3,3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonDidTouch(_ sender: Any) {
        
    }

    // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {
            return
        }
        
        if cellState.isSelected {
            myCustomCell.dayLabel.textColor = black
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                myCustomCell.dayLabel.textColor = white
            } else {
                myCustomCell.dayLabel.textColor = grey
            }
        }
    }
    
    // Function to handle the calendar selection
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {
            return
        }
        if cellState.isSelected {
            myCustomCell.selectedView.layer.cornerRadius =  15
            myCustomCell.selectedView.isHidden = false
        } else {
            myCustomCell.selectedView.isHidden = true
        }
    }
}
extension ViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2017 01 01")! // You can use date generated from a formatter
        let endDate = formatter.date(from: "2100 02 01")!                                // You can also use dates created from this function
        let aCalendar = Calendar.current                     // Make sure you set this up to your time zone. We'll just use default here
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 6,
                                                 calendar: aCalendar,generateInDates: .forAllMonths, generateOutDates: .tillEndOfGrid,firstDayOfWeek: .sunday)
        return parameters
    }
    
    
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CellView
        
        // Setup Cell text
        myCustomCell.dayLabel.text = cellState.text
        
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
}

extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

