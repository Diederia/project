//
//  CollectionViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    let dateCellIdentifier = "DateCellIdentifier"
    let contentCellIdentifier = "ContentCellIdentifier"
    let timeSlots = ["9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        self.collectionView .register(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: dateCellIdentifier)
        self.collectionView .register(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: contentCellIdentifier)
    }

    
    
    
    // MARK - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let alertController = UIAlertController(title: "Wilt u dit tijdstip inplannen", message: "Minimaal moet u een uur inplannen en u kunt dit met een half uur verlengen.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:  {
            (_)in
        }))
        self.present(alertController, animated: true, completion: nil)
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
                    dateCell.backgroundColor = UIColor(colorWithHexValue: 0xE1007A, alpha: 0.3)
                }
                
                else
                {
                    dateCell.backgroundColor = UIColor.white
                }
                
                return dateCell
            }
            
            else
            {
                let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath) as! ContentCollectionViewCell
                contentCell.contentLabel.font = UIFont.systemFont(ofSize: 13)
                contentCell.contentLabel.textColor = UIColor.black
                contentCell.contentLabel.text = "Vrij"
                if (indexPath as NSIndexPath).section % 2 != 0
                {
                    contentCell.backgroundColor = UIColor(colorWithHexValue: 0xE1007A, alpha: 0.3)
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

