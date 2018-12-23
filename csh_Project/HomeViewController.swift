//
//  HomeViewController.swift
//  csh_Project
//
//  Created by 조서현 on 2018. 11. 29..
//  Copyright © 2018년 comsoft. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController{

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextview = segue.destination as! HomeTableViewController
        if segue.identifier == "list1" {
            nextview.listnum = "list1"
        } else if segue.identifier == "list2" {
            nextview.listnum = "list2"
        } else if segue.identifier == "list3" {
            nextview.listnum = "list3"
        } else if segue.identifier == "list4" {
            nextview.listnum = "list4"
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}
