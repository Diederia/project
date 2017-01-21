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
    let dateCellIdentifier = "DateCellIdentifier"
    let contentCellIdentifier = "ContentCellIdentifier"
    let timeSlots = ["9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00",
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
    
//    var ref = FIRDatabase.database().reference()
//    var dataRef: FIRDatabaseReference!


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        dateLabel.text = CalendarDay.calendarDayDate
        
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
    func configurateCell(indexPath: IndexPath, bool: Bool, font: UIFont, textColor: UIColor, text: String, backgroundColor1: UIColor, backgroundColor2: UIColor) -> UICollectionViewCell {
        
        if bool == true {
            let cell: ContentCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
            cell.contentLabel.font = font
            cell.contentLabel.textColor = textColor
            cell.contentLabel.text = text
            if (indexPath as NSIndexPath).section % 2 != 0 {
                cell.backgroundColor = backgroundColor1
            } else {
                cell.backgroundColor = backgroundColor2
            }
            return cell
        } else {
            let cell: DateCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: dateCellIdentifier, for: indexPath) as! DateCollectionViewCell
            cell.dateLabel.font = font
            cell.dateLabel.textColor = textColor
            cell.dateLabel.text = text
            if (indexPath as NSIndexPath).section % 2 != 0 {
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
        stringIndexPath = stringIndexPath.replacingOccurrences(of: "[", with: " ")
        stringIndexPath = stringIndexPath.replacingOccurrences(of: "]", with: " ")
        return stringIndexPath
    }
    
    func alert(title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Terug", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)

    }
    
    func pickerAlert(title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.view.addSubview(pickerMenu)
        
        alertController.addAction(UIAlertAction(title: "Terug", style: UIAlertActionStyle.default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Ja",style: UIAlertActionStyle.default, handler:  {
            (_)in
            
            // check the request is within the schedule
            if self.selectedItem.section + self.selectedRow - 1 <= 28 {
                
                // place the use id in the cells
                CalendarDay.dataOfDate[self.convertIndexPath(indexPath: self.selectedItem)] = User.FirebaseID
                for _ in 1...self.selectedRow - 1 {
                    self.selectedItem = IndexPath(row: self.selectedItem.row , section: self.selectedItem.section + 1)
                    CalendarDay.dataOfDate[self.convertIndexPath(indexPath: self.selectedItem)] =  User.FirebaseID
                }
                
                // give section header the right id
                self.selectedItem = IndexPath(row: self.selectedItem.row , section: 0)
                CalendarDay.dataOfDate[self.convertIndexPath(indexPath: self.selectedItem)] =  User.FirebaseID
                
                // save the data of the day in FireBase
//                self.dataRef = self.ref.child("Data").child(CalendarDay.calendarDayDate)
//                self.dataRef.setValue(CalendarDay.dataOfDate)
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
        // check if section already is used, if not user could schedule the section
        if CalendarDay.dataOfDate.values.contains(User.FirebaseID!) {
            self.alert(title: "Error", message: "U heeft deze dag al ingepland.")
        } else if CalendarDay.dataOfDate[(self.convertIndexPath(indexPath: sectionName))] == nil {
            self.pickerAlert(title: " Wilt u " + timeSlots[self.selectedItem.section - 1] +  " uur inplannen? \n\n\n\n\n\n\n\n\n", message: " U moet minimaal 1 uur inplannen.")
        } else {
            self.alert(title: "Error", message: "De section is al ingepland")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return configurateCell(indexPath: indexPath, bool: false, font: UIFont.boldSystemFont(ofSize: 13), textColor: UIColor.black, text: "Tijd", backgroundColor1: UIColor.white, backgroundColor2: UIColor.white)
            } else {
                if CalendarDay.dataOfDate[(self.convertIndexPath(indexPath: indexPath))] != nil {
                    return configurateCell(indexPath: indexPath, bool: true, font: UIFont.boldSystemFont(ofSize: 13), textColor: UIColor.black, text: CalendarDay.dataOfDate[(self.convertIndexPath(indexPath:indexPath))]!, backgroundColor1: UIColor.green, backgroundColor2: UIColor.green)
        
                } else {
                    return configurateCell(indexPath: indexPath, bool: true, font: UIFont.boldSystemFont(ofSize: 13), textColor: UIColor.black, text: String((indexPath as NSIndexPath).row), backgroundColor1: UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1), backgroundColor2: UIColor.white)
                }
            }
        } else {
            if indexPath.row == 0 {
                return configurateCell(indexPath: indexPath, bool: false, font: UIFont.boldSystemFont(ofSize: 13), textColor: UIColor.black, text: timeSlots[((indexPath as NSIndexPath).section) - 1], backgroundColor1: UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1), backgroundColor2: UIColor.white)
            } else {
                if CalendarDay.dataOfDate[(self.convertIndexPath(indexPath:indexPath))] != nil {
                    return configurateCell(indexPath: indexPath, bool: true, font: UIFont.systemFont(ofSize: 13), textColor: UIColor.black, text: CalendarDay.dataOfDate[(self.convertIndexPath(indexPath:indexPath))]!, backgroundColor1: UIColor(red: 14/255.0, green: 210/255.0, blue: 21/255.0, alpha: 0.5), backgroundColor2: UIColor(red: 14/255.0, green: 210/255.0, blue: 21/255.0, alpha: 0.3))
                } else {
                    return configurateCell(indexPath: indexPath, bool: true, font: UIFont.systemFont(ofSize: 13), textColor: UIColor.black, text: "Vrij    ", backgroundColor1: UIColor(red: 242/255.0, green: 242/255.0, blue: 242/242.0, alpha: 1), backgroundColor2: UIColor.white)
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



