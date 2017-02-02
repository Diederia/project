//
//  CollectionViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//
// This view controller shows the schedule of the calendar day. As stundent, teacher or admin user you could schedule yourself in the collection view. All the data of the collection view is saved in FireBase.

import UIKit
import Firebase

class CollectionViewController: UIViewController  {
    
    // MARK: - outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Constants and variables
    let dateCellIdentifier = "DateCellIdentifier"
    let contentCellIdentifier = "ContentCellIdentifier"
    let timeSlots:[String] = ["9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00",
                     "13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30",
                     "18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00"]
    
    let hours:[String] = [" 1 uur ", " 1½ uur " , " 2 uur ", " 2½ uur "," 3 uur "," 3½ uur ",
                          " 4 uur", "4½ uur", " 5 uur ", " 5½ uur ", " 6 uur ", " 6½ uur ",
                          " 7 uur ", " 7½ uur ", " 8 uur ", " 8½ uur ", " 9 uur "]
   
    var pickerMenu: UIPickerView = UIPickerView()
    var sampleSegment: UISegmentedControl = UISegmentedControl ()
    var alertController: UIAlertController = UIAlertController()
    var selectedRow: Int = 2
    var selectedItem = IndexPath()
    var ref = FIRDatabase.database().reference()
    var userId = String()
    var userStatus = Int()
    var userData = [String:AnyObject]()
    
    // MARK: - Colors
    let colorDictionary: [String:UIColor] = ["lightWhite": UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1),
    "greyWhite": UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1),
    "green": UIColor(red: 0/255.0, green: 240/255.0, blue: 20/255.0, alpha: 1),
    "lightGreen": UIColor(red: 0/255.0, green: 200/255.0, blue: 20/255.0, alpha: 0.3),
    "greyGreen": UIColor(red: 0/255.0, green: 200/255.0, blue: 20/255.0, alpha: 0.5),
    "lightRed": UIColor(red: 230/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.3),
    "greyRed": UIColor(red: 230/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.5)]
    let white = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
    let black = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
    let pink = UIColor(red: 225/255.0, green: 0/255.0, blue: 122/255.0, alpha: 1.0)

    // MARK: - Override functions
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupCollectionView()
        setupPickerView()
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        coder.encode(CalendarDay.dataOfDate, forKey: "data")
        coder.encode(CalendarDay.calendarDayDate, forKey: "date")
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        CalendarDay.dataOfDate = coder.decodeObject(forKey: "data") as! [(String) : String]
        dateLabel.text = coder.decodeObject(forKey: "date") as! String?
        collectionView.reloadData()
        super.decodeRestorableState(with: coder)
    }
    
    // MARk: - Functions
    // Setup all items for the use of the collection view.
    func setupCollectionView() {
        dateLabel.text = CalendarDay.calendarDayDate
        collectionView.layer.borderWidth = 2
        collectionView.layer.borderColor = self.pink.cgColor
        
        userData = UserDefaults.standard.value(forKey: "userData") as! [String : AnyObject]
        self.userId = userData["id"] as! String
        self.userStatus = userData["userStatus"] as! Int
        
        self.collectionView .register(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: dateCellIdentifier)
        self.collectionView .register(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: contentCellIdentifier)
    }
    
    // Function to setup the picker view for the input of the user.
    func setupPickerView () {
        pickerMenu = UIPickerView(frame: CGRect(x: 10.0, y: 40.0, width: 250, height: 170))
        pickerMenu.delegate =  self;
        pickerMenu.dataSource = self;
        pickerMenu.showsSelectionIndicator = true
        pickerMenu.tintColor =  UIColor.red
        pickerMenu.reloadAllComponents()
    }
    
    // Function to handle all the parameters to configurate the cell of the collection view.
    func configurateCell(indexPath: IndexPath, contentCell: Bool, text: String, colorString: String) -> UICollectionViewCell {
        if contentCell == true {
            let cell = collectionView .dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
            cell.contentLabel.textColor = self.black
            cell.contentLabel.text = text
            cell.backgroundColor = self.getColor(indexPath: indexPath, colorString: colorString)
            return cell
        } else {
            let cell = collectionView .dequeueReusableCell(withReuseIdentifier: dateCellIdentifier, for: indexPath) as! DateCollectionViewCell
            cell.dateLabel.textColor = self.black
            cell.dateLabel.text = text
            cell.backgroundColor = self.getColor(indexPath: indexPath, colorString: colorString)
            return cell
        }
    }
    
    // Function the get the right background color of the cell.
    func getColor(indexPath: IndexPath, colorString: String) -> UIColor {
        var color = UIColor()
        if colorString == "green" || colorString == "white" {
            color = self.colorDictionary[colorString]!
        } else {
            if indexPath.section % 2 != 0 {
                color = self.colorDictionary["grey" + colorString]!
            } else {
                color = self.colorDictionary["light" + colorString]!
            }
        }
        return color
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    // Function to convert the index path to a string without brackets for FireBase.
    func convertIndexPath (indexPath: IndexPath) -> String {
        var stringIndexPath = String(describing: indexPath)
        stringIndexPath = stringIndexPath.replacingOccurrences(of: "[", with: "")
        stringIndexPath = stringIndexPath.replacingOccurrences(of: "]", with: "")
        return stringIndexPath
    }
    
    // Function for an alert.
    func alert(title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Terug", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)

    }
    
    // Function for an alert with a picker view.
    func alertWithPickerMenu(title: String, message: String, user: Int) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.view.addSubview(pickerMenu)
        
        alertController.addAction(UIAlertAction(title: "Terug", style: UIAlertActionStyle.default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Ja",style: UIAlertActionStyle.default, handler:  {
            (_)in
            if user == 0 {
                self.studentPickerView()
            } else if user == 1 {
                self.teacherPickerView()
            } else {
                self.adminPickerView()
            }
            
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Remove teacher id from the database when all hours are deleted.
    func removeTeacherId(){
        for i in 1...17 {
            let indexPath = (String(i) + ", " + String(self.selectedItem.row))
            if CalendarDay.dataOfDate[indexPath] != nil {
                return
            }
        }
        CalendarDay.dataOfDate.removeValue(forKey: String(0) + ", " + String(self.selectedItem.row))
        
    }
    
    // The picker view function when a teacher clicks on a cell.
    func teacherPickerView() {
        // check the request is within the schedule
        guard self.selectedItem.section + self.selectedRow <= 28 else {
            self.alert(title: "Error", message: "Plan de uren binnen de roostertijden.")
            return
        }
        
        // place the use id in the cells
        CalendarDay.dataOfDate["0, " + String(self.selectedItem.row)]  = self.userId
        for i in 0...self.selectedRow - 1 {
            let indexPath = IndexPath(row: self.selectedItem.row, section: self.selectedItem.section + i)
            let stringIndexPath = self.convertIndexPath(indexPath: indexPath)
            CalendarDay.dataOfDate[stringIndexPath] =  "Vrij"
        }
            
        // save the data of the day in FireBase
        self.ref.child("data").child(CalendarDay.calendarDayDate).setValue(CalendarDay.dataOfDate)
        self.collectionView.reloadData()
    }
    
    // The picker view function when a student clicks on a cell.
    func studentPickerView() {
        // check if the request is within the schedule
        guard self.selectedItem.section + self.selectedRow <= 28  else {
            self.alert(title: "Error", message: "Plan de uren binnen de roostertijden.")
            return
        }
        let section = self.selectedItem.section + self.selectedRow - 1
        let indexPath = IndexPath(row: self.selectedItem.row, section: section)
        let cell = self.collectionView.cellForItem(at: indexPath) as! ContentCollectionViewCell
        
        // check if teacher is avaible for the input of the student
        guard cell.contentLabel.text == "Vrij" else {
            self.alert(title: "Error", message: "De docent is niet beschikbaar op deze tijden. Check uw invoer.")
            return
        }
        for i in 0...self.selectedRow - 1 {
            let indexPath = String(self.selectedItem.section + i) + ", " + String(self.selectedItem.row)
            CalendarDay.dataOfDate.updateValue(self.userId, forKey: indexPath)
        }
        self.ref.child("data").child(CalendarDay.calendarDayDate).setValue(CalendarDay.dataOfDate)
        self.collectionView.reloadData()
    }
    
    func adminPickerView() {
        guard self.selectedItem.section + self.selectedRow <= 28  else {
            self.alert(title: "Foudmelding", message: "Verwijder binnen de uren van de roostertijden.")
            return
        }
        let section = self.selectedItem.section + self.selectedRow - 1
        let indexPath = IndexPath(row: self.selectedItem.row, section: section)
        let cell = self.collectionView.cellForItem(at: indexPath) as! ContentCollectionViewCell
        
        // check if teacher is avaible for the input of the student
        guard cell.contentLabel.text != "_" else {
            self.alert(title: "Foudmelding", message: "Deze uren kunnen niet verwijderd worden. Let op het aantal uren te verwijderen.")
            return
        }
        for i in 0...self.selectedRow - 1 {
            let indexPath = String(self.selectedItem.section + i) + ", " + String(self.selectedItem.row)
            CalendarDay.dataOfDate.removeValue(forKey: indexPath)
        }
        removeTeacherId()
        self.ref.child("data").child(CalendarDay.calendarDayDate).setValue(CalendarDay.dataOfDate)
        self.collectionView.reloadData()
    }
}
    

// MARK: - UICollectionView
extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 8
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
        self.selectedItem = indexPath
        let cell = collectionView.cellForItem(at: indexPath) as! ContentCollectionViewCell
        
        // Check if it's an admin user and if the cell is not empty.
        if self.userStatus == 2 && cell.contentLabel.text != "_" {
            self.alertWithPickerMenu(title: " Wilt u " + timeSlots[self.selectedItem.section - 1] +  " verwijderen? \n\n\n\n\n\n\n\n\n", message: " U moet minimaal 1 uur verwijderen.", user: self.userStatus)
        }
        
        guard cell.contentLabel.text == "Vrij" || cell.contentLabel.text == "_" else{
            self.alert(title: "Foutmelding", message: "De sectie is al ingepland")
            return
        }
        
        // Check if it's a student and setup picker view.
        if cell.contentLabel.text == "Vrij" {
            guard self.userStatus == 0 && indexPath.row != 0 else {
                self.alert(title: "Foutmelding", message: "U kunt als docent geen docent reserveren.")
                return
            }
            self.alertWithPickerMenu(title: " Wilt u " + timeSlots[self.selectedItem.section - 1] +  " uur inplannen? \n\n\n\n\n\n\n\n\n", message: " U moet minimaal 1 uur inplannen.", user: self.userStatus)
            
        // Check if it's a teacher and setup picker view.
        } else if cell.contentLabel.text == "_" {
            guard self.userStatus == 1 else {
                self.alert(title: "Foutmelding", message: "U kunt als leerling geen beschikbare tijden invoeren.")
                return
            }
            
            guard CalendarDay.dataOfDate.values.contains(self.userId) == false else {
                self.alert(title: "Foutmelding", message: "U heeft deze dag al ingepland.")
                return
            }
            self.alertWithPickerMenu(title: " Wilt u " + self.timeSlots[self.selectedItem.section - 1] +  " uur inplannen? \n\n\n\n\n\n\n\n\n", message: "U moet minimaal 1 uur inplannen.", user: self.userStatus)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return configurateCell(indexPath: indexPath,
                                       contentCell: false,
                                       text: "Tijd",
                                       colorString: "White")
                
            } else {
                if CalendarDay.dataOfDate[(self.convertIndexPath(indexPath: indexPath))] != nil {
                    return configurateCell(indexPath: indexPath,
                                           contentCell: true,
                                           text: CalendarDay.dataOfDate[(self.convertIndexPath(indexPath:indexPath))]!,
                                           colorString: "green")
        
                } else {
                    return configurateCell(indexPath: indexPath,
                                           contentCell: true,
                                           text: "Vrij",
                                           colorString: "White")
                }
            }
        } else {
            if indexPath.row == 0 {
                return configurateCell(indexPath: indexPath,
                                       contentCell: false,
                                       text: timeSlots[((indexPath as NSIndexPath).section) - 1],
                                       colorString: "White")
            } else {
                if CalendarDay.dataOfDate[(self.convertIndexPath(indexPath:indexPath))] != nil {
                    var color = String()
                    if CalendarDay.dataOfDate[(self.convertIndexPath(indexPath:indexPath))] == "Vrij"{
                        color = "Green"
                    }
                    else {
                        color = "Red"
                    }
                    return configurateCell(indexPath: indexPath,
                                           contentCell: true,
                                           text: CalendarDay.dataOfDate[(self.convertIndexPath(indexPath:indexPath))]!,
                                           colorString: color)
                } else {
                    return configurateCell(indexPath: indexPath,
                                           contentCell: true,
                                           text: "_",
                                           colorString: "White")
                }
            }
        }
    }
}

// MARK: - UIPickerView
extension CollectionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 17
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hours[row] as String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = 2 + row
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
}




