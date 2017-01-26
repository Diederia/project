//
//  CollectionViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

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
    var dataRef: FIRDatabaseReference!
    var userId = String()
    var userStatus = Int()
    var userData = [String:AnyObject]()
    
    // MARK: - colors
    let white = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
    let black = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
    let grey = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
    let green = UIColor(red: 0/255.0, green: 240/255.0, blue: 20/255.0, alpha: 1)
    let lightGreen = UIColor(red: 0/255.0, green: 200/255.0, blue: 20/255.0, alpha: 0.3)
    let greyGreen = UIColor(red: 0/255.0, green: 200/255.0, blue: 20/255.0, alpha: 0.5)
    let lightRed = UIColor(red: 230/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.3)
    let greyRed = UIColor(red: 230/255.0, green: 20/255.0, blue: 20/255.0, alpha: 0.5)

    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        userData = UserDefaults.standard.value(forKey: "userData") as! [String : AnyObject]
        self.userId = userData["id"] as! String
        self.userStatus = userData["userStatus"] as! Int

        dateLabel.text = CalendarDay.calendarDayDate
        dateLabel.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        
        self.collectionView .register(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: dateCellIdentifier)
        self.collectionView .register(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: contentCellIdentifier)
        
        pickerMenu = UIPickerView(frame: CGRect(x: 10.0, y: 40.0, width: 250, height: 170))
        pickerMenu.delegate =  self;
        pickerMenu.dataSource = self;
        pickerMenu.showsSelectionIndicator = true
        pickerMenu.tintColor =  UIColor.red
        pickerMenu.reloadAllComponents()
        
    }
    
    
    // MARk - Functions
    func convertRow (row: Int) -> String {
        return timeSlots[(row - 1)]
    }
    
    func configurateCell(indexPath: IndexPath, bool: Bool, font: UIFont, textColor: UIColor, text: String, backgroundColor1: UIColor, backgroundColor2: UIColor) -> UICollectionViewCell {
        
        if bool == true {
            let cell = collectionView .dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
            cell.contentLabel.font = font
            cell.contentLabel.textColor = textColor
            cell.contentLabel.text = text
            if indexPath.section % 2 != 0 {
                cell.backgroundColor = backgroundColor1
            } else {
                cell.backgroundColor = backgroundColor2
            }
            return cell
        } else {
            let cell = collectionView .dequeueReusableCell(withReuseIdentifier: dateCellIdentifier, for: indexPath) as! DateCollectionViewCell
            cell.dateLabel.font = font
            cell.dateLabel.textColor = textColor
            cell.dateLabel.text = text
            if indexPath.section % 2 != 0 {
                cell.backgroundColor = backgroundColor1
            } else {
                cell.backgroundColor = backgroundColor2
            }
            return cell
        }
    

    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    func convertIndexPath (indexPath: IndexPath) -> String {
        var stringIndexPath = String(describing: indexPath)
        stringIndexPath = stringIndexPath.replacingOccurrences(of: "[", with: "")
        stringIndexPath = stringIndexPath.replacingOccurrences(of: "]", with: "")
        return stringIndexPath
    }
    
    func alert(title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Terug", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)

    }
    
    func pickerAlertStudent(title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.view.addSubview(pickerMenu)
        
        alertController.addAction(UIAlertAction(title: "Terug", style: UIAlertActionStyle.default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Ja",style: UIAlertActionStyle.default, handler:  {
            (_)in
            
            
            // check the request is within the schedule
            if self.selectedItem.section + self.selectedRow <= 28 {
                let section = self.selectedItem.section + self.selectedRow - 1

                let indexPath = IndexPath(row: self.selectedItem.row, section: section)
                let cell = self.collectionView.cellForItem(at: indexPath) as! ContentCollectionViewCell

                // check if teacher is avaible for the input of the student
                if cell.contentLabel.text == "Vrij" {
                    
                    for i in 0...self.selectedRow - 1 {
                        let indexPath = String(self.selectedItem.section + i) + ", " + String(self.selectedItem.row)
                        CalendarDay.dataOfDate.updateValue(self.userId, forKey: indexPath)
                    }
                    self.ref.child("data").child(CalendarDay.calendarDayDate).setValue(CalendarDay.dataOfDate)
                    
                } else {
                    self.alert(title: "Error", message: "De docent is niet beschikbaar op deze tijden. Check uw invoer.")
                }
                
            } else {
                self.alert(title: "Error", message: "Plan de uren binnen de roostertijden.")
            }
            
            self.collectionView.reloadData()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func pickerAlertTeacher(title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.view.addSubview(pickerMenu)
        
        alertController.addAction(UIAlertAction(title: "Terug", style: UIAlertActionStyle.default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Ja",style: UIAlertActionStyle.default, handler:  {
            (_)in
            
            // check the request is within the schedule
            if self.selectedItem.section + self.selectedRow <= 28 {
                
                // place the use id in the cells
                CalendarDay.dataOfDate["0, " + String(self.selectedItem.row)]  = self.userId
                
                for i in 0...self.selectedRow - 1 {
                    let indexPath = IndexPath(row: self.selectedItem.row, section: self.selectedItem.section + i)
                    let stringIndexPath = self.convertIndexPath(indexPath: indexPath)
                    CalendarDay.dataOfDate[stringIndexPath] =  "Vrij"
                }
            
                // save the data of the day in FireBase
                 self.ref.child("data").child(CalendarDay.calendarDayDate).setValue(CalendarDay.dataOfDate)
                
            } else {
                self.alert(title: "Error", message: "Plan de uren binnen de roostertijden.")
            }
            self.collectionView.reloadData()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
    

// MARK - UICollectionViewDataSource
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
        
        self.selectedItem = indexPath
        
        let sectionName = IndexPath(row: self.selectedItem.row , section: 0)
        
        let cell = collectionView.cellForItem(at: indexPath) as! ContentCollectionViewCell
        
        // check if section already is used, if not user could schedule the section
        
        if CalendarDay.dataOfDate.values.contains(self.userId) {
            self.alert(title: "Foutmelding", message: "U heeft deze dag al ingepland.")
            
        } else if CalendarDay.dataOfDate[(self.convertIndexPath(indexPath: sectionName))] == nil {
            
            if cell.contentLabel.text == "_" {
                if self.userStatus == 1 {
                    self.pickerAlertTeacher(title: " Wilt u " + timeSlots[self.selectedItem.section - 1] +  " uur inplannen? \n\n\n\n\n\n\n\n\n",
                                            message: " U moet minimaal 1 uur inplannen.")
                } else {
                    self.alert(title: "Foutmelding", message: "U kunt als leerling geen beschikbare tijden invoeren.")
                }

            }
        
        } else if cell.contentLabel.text == "Vrij" {
            if self.userStatus == 0 {
                self.pickerAlertStudent(title: " Wilt u " + timeSlots[self.selectedItem.section - 1] +  " uur inplannen? \n\n\n\n\n\n\n\n\n",
                                        message: " U moet minimaal 1 uur inplannen.")
            } else {
                self.alert(title: "Foutmelding", message: "U kunt als docent geen docent reserveren.")
            }
        } else {
            self.alert(title: "Foutmelding", message: "De sectie is al ingepland")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return configurateCell(indexPath: indexPath,
                                       bool: false, font: UIFont.boldSystemFont(ofSize: 13),
                                       textColor: UIColor.black,
                                       text: "Tijd",
                                       backgroundColor1: self.white,
                                       backgroundColor2: self.white)
                
            } else {
                if CalendarDay.dataOfDate[(self.convertIndexPath(indexPath: indexPath))] != nil {
                    return configurateCell(indexPath: indexPath,
                                           bool: true,
                                           font: UIFont.boldSystemFont(ofSize: 13),
                                           textColor: UIColor.black,
                                           text: CalendarDay.dataOfDate[(self.convertIndexPath(indexPath:indexPath))]!,
                                           backgroundColor1: self.green,
                                           backgroundColor2: self.green)
        
                } else {
                    return configurateCell(indexPath: indexPath,
                                           bool: true,
                                           font: UIFont.boldSystemFont(ofSize: 13),
                                           textColor: UIColor.black,
                                           text: "Vrij",
                                           backgroundColor1: self.grey,
                                           backgroundColor2: self.white)
                }
            }
        } else {
            if indexPath.row == 0 {
                return configurateCell(indexPath: indexPath,
                                       bool: false,
                                       font: UIFont.boldSystemFont(ofSize: 13),
                                       textColor: UIColor.black,
                                       text: timeSlots[((indexPath as NSIndexPath).section) - 1],
                                       backgroundColor1: self.grey,
                                       backgroundColor2: self.white)
            } else {
                if CalendarDay.dataOfDate[(self.convertIndexPath(indexPath:indexPath))] != nil {
                    var color1 = UIColor()
                    var color2 = UIColor()
                    if CalendarDay.dataOfDate[(self.convertIndexPath(indexPath:indexPath))] == "Vrij"{
                        color1 = self.greyGreen
                        color2 = self.lightGreen
                    }
                    else {
                        color1 = self.greyRed
                        color2 = self.lightRed
                    }
                    return configurateCell(indexPath: indexPath,
                                           bool: true,
                                           font: UIFont.systemFont(ofSize: 13),
                                           textColor: UIColor.black,
                                           text: CalendarDay.dataOfDate[(self.convertIndexPath(indexPath:indexPath))]!,
                                           backgroundColor1: color1,
                                           backgroundColor2: color2)
                } else {
                    return configurateCell(indexPath: indexPath,
                                           bool: true,
                                           font: UIFont.systemFont(ofSize: 13),
                                           textColor: UIColor.black, text: "_",
                                           backgroundColor1: self.grey,
                                           backgroundColor2: self.white)
                }
            }
        }
    }
}

// MARK - UIPickerViewDataSource
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



