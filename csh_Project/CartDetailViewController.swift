//
//  CartDetailViewController.swift
//  csh_Project
//
//  Created by 조서현 on 2018. 12. 21..
//  Copyright © 2018년 comsoft. All rights reserved.
//

import UIKit
struct DetailCart{
    var name: String!
    var menuimg: URL!
    var menu: String!
    var price: String!
}

class CartDetailViewController: UIViewController {

    @IBOutlet weak var shopname: UILabel!
    @IBOutlet weak var menuimg: UIImageView!
    @IBOutlet weak var menu: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var Location: UILabel!
    
    var preCell = DetailCart()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 101/255, green: 209/255, blue: 206/255, alpha: 1.0)
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        shopname.text? = preCell.name
        menu.text? = preCell.menu
        price.text? = preCell.price
        
        if let data = try? Data(contentsOf: preCell.menuimg) {
            let image = UIImage(data: data)
            menuimg.image = image
        }
    
        
    }
    


}
