//
//  SectionedTVC.swift
//  SectionExample
//
//  Created by Jeff Devine on 8/8/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//


import UIKit
import Parse
import ParseUI

class SectionedTVC: PFQueryTableViewController {
    
    
    var sections = [String : Array<Int>]()
    var sectionMap = NSMutableDictionary()
    
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Use the Parse built-in user class
        self.parseClassName = "_User"
        
        //This is a custom column in the user class.
        self.textKey = "lastName"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
  
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
     
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: self.parseClassName!)
        
        query.limit = 1000
        
        //It's very important to sort the query.  Otherwise you'll end up with unexpected results
        query.orderByAscending("lastName")
        
        
        query.cachePolicy = PFCachePolicy.CacheThenNetwork
        
        return query
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell",  forIndexPath: indexPath) as! UsersTVCell
        
        //These two columns are custom fields.  You'll need to add them to the Parse _User class manually.
        
        let lastName = object!["lastName"] as! String
        let firstName = object!["firstName"] as! String
        
        let displayName = lastName + ", " + firstName
        
        
        cell.userDisplayName?.text = displayName
        
        
        return cell
    }
    
    //MARK: - Index. Configure the TVC to show an index with the first letter of user last names
    
    func letterForSection(section: NSInteger) -> NSString {
        
        return sectionMap.objectForKey(section) as! NSString
        
    }
    
    override func objectsDidLoad(error: NSError!) {
        
        super.objectsDidLoad(error)
        
        
        
        sections.removeAll(keepCapacity: false)
        
        sectionMap.removeAllObjects()
        
        
        
        var section = 0
        
        var rowIndex = 0
        
        
        for object in objects! {
            
            
            
            if let lastName = object["lastName"] as? String {
                
                
                var letter  = prefix(lastName, 1)
                
                
                var objectsInSection = sections[letter]
                
                
                if (objectsInSection == nil) {
                    
                    objectsInSection = Array<Int>()
                    
                    sectionMap[section++] = letter
                    
                }
                
                objectsInSection?.append(rowIndex++)
                
                sections[letter] = objectsInSection
            }
            
            
        }
        
        tableView.reloadData()
        
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject? {
        
        let letter = letterForSection(indexPath.section)
        
        let rows = sections[letter as String]
        
        let rowIndex = rows![indexPath.row]
        
        return objects![rowIndex] as? PFObject
        
        
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return sections.count
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let letter = letterForSection(section)
        
        let rowIndecesInSection = sections[letter as String]!
        
        return rowIndecesInSection.count
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let letter = letterForSection(section) as String?
        
        return letter
        
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        //
        let sections = self.sections.keys
        let sortedLetters = sorted(sections, <)
        
        return sortedLetters
    }
    
  
    
}

