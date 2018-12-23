//
//  CartTableViewController.swift
//  csh_Project
//
//  Created by 조서현 on 2018. 12. 12..
//  Copyright © 2018년 comsoft. All rights reserved.
//

import UIKit
import FirebaseDatabase

//내가 원하는대로 구조체 사용해서 형태 만들기
struct Wish {
    var name: String!
    var menuimg: String!
    var menu: String!
    var price: String!
    var star: String!
    var heart: String!
    var tel: String!
    var info: String!
    var shopimg: String!
    var shopid: String!
    var listnum: String!
    
}

class WishTableViewController: UITableViewController {
    var listnum: String = ""
    
    var ref: DatabaseReference!
    var wishs: [Wish] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }


    //디비 연결해서 데이터 가져오기
    override func viewWillAppear(_ animated: Bool) {
        resolveWhishs()
    }
    
    //네트워크 연결해서 데이터를 가져옴
    func resolveWhishs() {  //데이터 읽고쓰기
        //예전에 가져왔던 데이터를 모두 지우고 다시 가져와야지 쌓이지 않음
        self.wishs.removeAll()
        
        
        
     
        let list:Set<String> = ["list1","list2","list3","list4"]
        for l in list {
            var newItem = Wish()
            ref.child("shop/"+l).observeSingleEvent(of: .value) { (snapshot) in
                for child in snapshot.children {
                    let node = child as! DataSnapshot
                    let wish = node.value as! [String: String]
                    
                    if wish["heart"] == "true" {
                        newItem.menuimg = wish["menuImg"]
                        newItem.name = wish["name"]
                        newItem.menu = wish["menu"]
                        newItem.price = wish["price"]
                        newItem.star = wish["star"]
                        newItem.heart = wish["heart"]
                        newItem.tel = wish["tel"]
                        newItem.info = wish["info"]
                        newItem.shopimg = wish["shopImg"]
                        newItem.shopid = wish["id"]
                        newItem.listnum = l
                        self.wishs.append(newItem)
                        
                        //비동기방식으로 데이터를 가져오는 시점이테이블을 가져오고 난 시점일 수 있으므로 가져와서 반영하는 과정이 필요
                        self.tableView.reloadData()
                    }
                }
            }
            print(self.wishs.count)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishs.count
    }
    
    
    
    //테이블뷰로 이미지 넣어서 데이터 불러오기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishCell", for: indexPath)
        let wish = wishs[indexPath.row]
        cell.textLabel?.text = wish.name
        cell.detailTextLabel?.text = "⭐️\(wish.star!)  \(wish.menu!)"
        if let url = URL(string: wish.shopimg),
            let data = try? Data(contentsOf: url) {
            let image = UIImage(data: data)
            cell.imageView?.image = image
            
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var selectedCell = Wish()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            selectedCell = wishs[indexPath.row]
        }
        
        let nextview = segue.destination as! WishDetailViewController
        if let menuimg = selectedCell.menuimg,
            let name = selectedCell.name,
            let menu = selectedCell.menu,
            let price = selectedCell.price,
            let star = selectedCell.star,
            let heart = selectedCell.heart,
            let tel = selectedCell.tel,
            let id = selectedCell.shopid,
            let info = selectedCell.info{
            
            nextview.preCell.menuimg = menuimg
            nextview.preCell.name = name
            nextview.preCell.menu = menu
            nextview.preCell.price = price
            nextview.preCell.star = star
            nextview.preCell.heart = heart
            nextview.preCell.tel = tel
            nextview.preCell.info = info
            nextview.preCell.id = id
        }
        nextview.preCell.listnum = listnum
        
    }

}
