//
//  CartTableViewController.swift
//  csh_Project
//
//  Created by 조서현 on 2018. 12. 21..
//  Copyright © 2018년 comsoft. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Cart {
    var name: String!
    var menuimg: String!
    var menu: String!
    var price: String!
    
}

class CartTableViewController: UITableViewController {
    
    var ref: DatabaseReference!
    var carts: [Cart] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 101/255, green: 209/255, blue: 206/255, alpha: 1.0)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resolveCarts()
    }

    //네트워크 연결해서 데이터를 가져옴
    func resolveCarts() {  //데이터 읽고쓰기
        //예전에 가져왔던 데이터를 모두 지우고 다시 가져와야지 쌓이지 않음
        self.carts.removeAll()
        
        
        ref.child("cart/").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let node = child as! DataSnapshot
                let cart = node.value as! [String: String]
                
                //데이터를 출력하기위해 데이터 준비
                var newItem = Cart()
                newItem.menuimg = cart["menuimg"]
                newItem.name = cart["name"]
                newItem.menu = cart["menu"]
                newItem.price = cart["price"]
                self.carts.append(newItem)
                print(self.carts.count)
            }
            //비동기방식으로 데이터를 가져오는 시점이테이블을 가져오고 난 시점일 수 있으므로 가져와서 반영하는 과정이 필요
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carts.count
    }
    
    
    
    //테이블뷰로 이미지 넣어서 데이터 불러오기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath)
        let cart = carts[indexPath.row]
        cell.textLabel?.text = cart.name!
        cell.detailTextLabel?.text = cart.menu!
        if let url = URL(string: cart.menuimg),
            let data = try? Data(contentsOf: url) {
            let image = UIImage(data: data)
            cell.imageView?.image = image
            
        }
        return cell
    }

    
    var selectedCell = Cart()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            selectedCell = carts[indexPath.row]
        }
        
        let nextview = segue.destination as! CartDetailViewController
        if let url = URL(string:selectedCell.menuimg),
            let name = selectedCell.name,
            let menu = selectedCell.menu,
            let price = selectedCell.price{
            nextview.preCell.menuimg = url
            nextview.preCell.name = name
            nextview.preCell.menu = menu
            nextview.preCell.price = price
            
        }
        
    }

}
