//
//  ViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 10/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Firebase

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var goToCollectionView: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    let white = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0 )
    let black = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
    let blue =  UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
    let formatter = DateFormatter()
    let timeSlots:[String] = ["9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00",
                              "13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30",
                              "18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00"]

    var previewIds = [String]()
    var previewHours = [String]()
    var testCalendar = Calendar.current
    var ref =  FIRDatabase.database().reference()
    var dataRef: FIRDatabaseReference!
    var userData = [String:AnyObject]()
    var counter = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userData = UserDefaults.standard.value(forKey: "userData") as! [String : AnyObject]
        if userData["userStatus"] as! Int? == 2 {
            registerButton.isHidden = false
        } else {
            registerButton.isHidden = true
        }

        tableView.isHidden = true
        goToCollectionView.isHidden = true
        
        TimeZone.ReferenceType.default = TimeZone(abbreviation: "UTC")!
        formatter.timeZone = TimeZone.ReferenceType.default
        formatter.dateFormat = "yyyy MM dd"
        formatter.locale = testCalendar.locale

        calendarView.dataSource = self
        calendarView.delegate = self
        
        calendarView.registerCellViewXib(file: "CellView") // Registering your cell is manditory
        calendarView.cellInset = CGPoint(x: 3, y: 3)       // default is (3,3)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - Actions
    @IBAction func next(_ sender: Any) {
        self.calendarView.scrollToSegment(.next) {
            self.calendarView.visibleDates({ (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)

            })
        }
    }
    
    @IBAction func previous(_ sender: Any) {
        self.calendarView.scrollToSegment(.previous) {
            self.calendarView.visibleDates({ (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
            })
        }
    }
    
    @IBAction func logoutDidTouch(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout", message:
            "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default,handler: {
            (_)in
            try! FIRAuth.auth()!.signOut()
            self.performSegue(withIdentifier: "viewToLogin", sender: self)
        }))
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func settingsDidTouch(_ sender: Any) {
        self.performSegue(withIdentifier: "viewToSettings", sender: self)
    }
    
    @IBAction func registerDidTouch(_ sender: Any) {
        self.performSegue(withIdentifier: "viewToRegister", sender: self)
    }
    


    
    // MARK - Functions
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first else {
            return
        }
        let month = testCalendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        monthLabel.text = monthName
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
                myCustomCell.dayLabel.textColor = blue
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

    func configuratePreview() {
        var userId = String()
        var begintTime = String()
        var endTime = String()
        
        for i in self.counter...8 {
            if CalendarDay.dataOfDate.keys.contains(("0, " + String(i))) == true {
                print("i:\(i)")
                userId = CalendarDay.dataOfDate["0, " + String(i)]!
                for j in 1...28 {
                    print("j:\(j)")
                    if CalendarDay.dataOfDate.keys.contains(String(j) + ", " + String(i)) == true {
                        begintTime = self.timeSlots[j - 1]
                        for k in j...28 {
                            print("k:\(j)")
                            if CalendarDay.dataOfDate.keys.contains(String(k) + ", " + String(i)) == false {
                                endTime = self.timeSlots[k - 2]
                                self.previewIds.append(userId)
                                self.previewHours.append(begintTime + " - " + endTime)
                                self.counter += 1
                                break
                            }
                        }
                    break
                    }
                }
            }
        }
    }
}

// MARK - JT Apple Calendar
extension ViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        let startDate = formatter.date(from: "2017 01 01")! // You can use date generated from a formatter
        let endDate = formatter.date(from: "2100 02 01")!                                // You can also use dates created from this function
        let aCalendar = Calendar.autoupdatingCurrent                     // Make sure you set this up to your time zone. We'll just use default here
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6,
                                                 calendar: aCalendar,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday)
        monthLabel.text = "January"
        return parameters
    }
    

    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CellView
        
        // Setup Cell text
        myCustomCell.dayLabel.text = cellState.text
        
        if testCalendar.isDateInToday(date) {
            myCustomCell.backgroundColor = black
            myCustomCell.layer.cornerRadius =  15
        } else {
            myCustomCell.backgroundColor = UIColor(red: 225/255.0, green: 0/255.0, blue: 122/255.0, alpha: 0.5)
            myCustomCell.layer.cornerRadius =  0
        }

        
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        
        self.previewHours.removeAll()
        self.previewIds.removeAll()
        self.counter = 1

        tableView.isHidden = false
        goToCollectionView.isHidden = false
        
        let month = Int(cellState.date.description[5..<7])
        let monthName = DateFormatter().monthSymbols[(month!-1) % 12]
        CalendarDay.calendarDayDate = cellState.text + " " + monthName
        
        // retrieve data from FireBase
        CalendarDay.dataOfDate.removeAll()
        self.dataRef = self.ref.child("data").child(CalendarDay.calendarDayDate)
        
        self.dataRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in result {
                    CalendarDay.dataOfDate[snap.key] = snap.value as! String?
                }
                
            }
            self.configuratePreview()
            self.performSelector(onMainThread: #selector(ViewController.reloadTableView), with: nil, waitUntilDone: true)
        })
        
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {

        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
        
    }
    
    func scrollDidEndDecelerating(for calendar: JTAppleCalendarView) {
        self.setupViewsOfCalendar(from: calendarView.visibleDates())
    }
    
}



// MARK - UITableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.previewIds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomCell
        cell.idLabel.text = self.previewIds[indexPath.row]
        cell.hoursLabel.text = self.previewHours[indexPath.row]
        return cell
    }
}


extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }
    
}


