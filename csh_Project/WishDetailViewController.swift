//
//  WishDetailViewController.swift
//  csh_Project
//
//  Created by comsoft on 2018. 12. 19..
//  Copyright © 2018년 comsoft. All rights reserved.
//

import UIKit
import Firebase

struct WishDetailShop {
    var name: String!
    var menuimg: String!
    var menu: String!
    var price: String!
    var star: String!
    var heart: String!
    var tel: String!
    var info: String!
    var listnum: String!
    var id: String!
}

class WishDetailViewController: UIViewController {
    var ref: DatabaseReference!
    
    @IBOutlet var ShopName: UILabel!
    @IBOutlet var MenuName: UILabel!
    @IBOutlet var MenuPrice: UILabel!
    @IBOutlet var MenuImg: UIImageView!
    @IBOutlet var MenuStarLabel: UILabel!
    @IBOutlet var Info: UILabel!
    @IBOutlet var Tel: UILabel!
    @IBOutlet var heartbtn: UIButton!
    
    var preCell = WishDetailShop()
    
    @IBOutlet weak var orderbtn: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.navigationController?.navigationBar.tintColor = UIColor(red: 101/255, green: 209/255, blue: 206/255, alpha: 1.0)
        self.navigationController?.navigationBar.topItem?.title = ""
        
            orderbtn.layer.cornerRadius = 10
        
            ShopName.text? = preCell.name
            MenuName.text? = preCell.menu
            MenuPrice.text? = preCell.price
            MenuStarLabel.text? = preCell.star
            Info.text? = preCell.info
            Tel.text? = preCell.tel
            if let data = try? Data(contentsOf: URL(string:preCell.menuimg)!) {
                let image = UIImage(data: data)
                MenuImg.image = image
            }
        
            if preCell.heart == "true" {
                heartbtn.setTitle("❤️", for: .normal)
            } else if preCell.heart == "false" {
                heartbtn.setTitle("🖤", for: .normal)
            }
    }
    
    @IBAction func HeartClick(_ sender: Any) {
        if preCell.heart == "true" {
            heartbtn.setTitle("🖤", for: .normal)
            preCell.heart = "false"
            ref.child("shop/"+preCell.listnum).child(preCell.id).child("heart").setValue("false")
        } else if preCell.heart == "false" {
            heartbtn.setTitle("❤️", for: .normal)
            preCell.heart = "true"
            ref.child("shop/"+preCell.listnum).child(preCell.id).child("heart").setValue("true")
        }
    }
    
    
    @IBAction func OrderBtn(_ sender: Any) {
        
        let newCart = ["name":preCell.name, "menu":preCell.menu, "menuimg":preCell.menuimg, "price":preCell.price] as [String : Any]
        ref.child("cart/").childByAutoId().setValue(newCart)
        
        let dialog = UIAlertController(title: "주문완료!", message: "주문이 완료되었습니다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        dialog.addAction(okAction)
        self.present(dialog,animated: true, completion: nil)
       // _ = UIAlertAction(title:"주문완료!", style:UIAlertActionStyle.default){(action) in
        //}
        
    }
    
}
