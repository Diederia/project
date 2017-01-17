//
//  CollectionViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDataSource,UIPickerViewDelegate
{
    let dateCellIdentifier = "DateCellIdentifier"
    let contentCellIdentifier = "ContentCellIdentifier"
    let timeSlots = ["9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00"]
    
    let hours:[String] = [" 1 uur ", " 1½ uur " , " 2 uur ", " 2½ uur "," 3 uur "," 3½ uur ", " 4 uur", "4½ uur", " 5 uur ", " 5½ uur ", " 6 uur ", " 6½ uur ", " 7 uur ", " 7½ uur ", " 8 uur ", " 8½ uur "]
   
    var pickerMenu: UIPickerView = UIPickerView()
    var sampleSegment: UISegmentedControl = UISegmentedControl ()
    var alertController: UIAlertController = UIAlertController()
    var selectedRow: Int = 2
    var selectedItem: IndexPath = IndexPath(row:0, section: 0)
    var timeScheduleData = [IndexPath: String]()

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
    
    func alert(title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Terug", style: UIAlertActionStyle.default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Ja",style: UIAlertActionStyle.default, handler:  {
            (_)in
            print(self.selectedRow)
            print(self.selectedItem)
            self.timeScheduleData[self.selectedItem] = userInfo.userID
            print (self.timeScheduleData)
            for _ in 1...self.selectedRow - 1 {
                self.selectedItem = IndexPath(row: self.selectedItem.row , section: self.selectedItem.section + 1)
                print(self.selectedItem)
                self.timeScheduleData[self.selectedItem] =  userInfo.userID
            }

            self.collectionView.reloadData()
        }))
        alertController.view.addSubview(pickerMenu)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 16
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return hours[row] as String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        selectedRow = 2 + row
        print(selectedRow)
        
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
 
    // MARK - UICollectionViewDataSource
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath
        print(selectedItem)
        self.alert(title: " Wilt u " + timeSlots[self.selectedItem.section - 1] +  " uur inplannen? \n\n\n\n\n\n\n\n\n", message: " U moet minimaal 1 uur inplannen.")
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 28
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if (indexPath as NSIndexPath).section == 0
        {
            if (indexPath as NSIndexPath).row == 0
            {
                let timeCell : DateCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: dateCellIdentifier, for: indexPath) as! DateCollectionViewCell
                timeCell.backgroundColor = UIColor.white
                timeCell.dateLabel.font = UIFont.systemFont(ofSize: 13)
                timeCell.dateLabel.textColor = UIColor.black
                timeCell.dateLabel.text = "Tijd"
                
                return timeCell
            }
            
            else
            {
                let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
                contentCell.contentLabel.font = UIFont.systemFont(ofSize: 13)
                contentCell.contentLabel.textColor = UIColor.black
                contentCell.contentLabel.text = "Slot" + String((indexPath as NSIndexPath).row)
                
                if (indexPath as NSIndexPath).section % 2 != 0
                {
                    contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                }
                
                else
                {
                    contentCell.backgroundColor = UIColor.white
                }
                
                return contentCell
            }
        }
        
        else
        {
            if (indexPath as NSIndexPath).row == 0
            {
                let dateCell : DateCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: dateCellIdentifier, for: indexPath) as! DateCollectionViewCell
                dateCell.dateLabel.font = UIFont.systemFont(ofSize: 13)
                dateCell.dateLabel.textColor = UIColor.black
                dateCell.dateLabel.text = timeSlots[((indexPath as NSIndexPath).section) - 1]
                if (indexPath as NSIndexPath).section % 2 != 0 {
                    dateCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                }
                
                else
                {
                    dateCell.backgroundColor = UIColor.white
                }
                
                return dateCell
            }
            
            else
            {
                if timeScheduleData[((indexPath as NSIndexPath) as IndexPath)] != nil
                {
                    let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
                    contentCell.backgroundColor = UIColor(red: 14/255.0, green: 210/255.0, blue: 21/255.0, alpha: 0.4)
                    contentCell.contentLabel.text = userInfo.userID
                    return contentCell
                }
                else
                {
                    let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
                    contentCell.contentLabel.font = UIFont.systemFont(ofSize: 13)
                    contentCell.contentLabel.textColor = UIColor.black
                    contentCell.contentLabel.text = "Vrij"
                    if (indexPath as NSIndexPath).section % 2 != 0
                    {
                        contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                    }
                    else
                    {
                        contentCell.backgroundColor = UIColor.white
                    }
                    
                    return contentCell
                }

            }
        }
    }
}



