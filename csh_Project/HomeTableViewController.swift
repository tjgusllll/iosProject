//
//  HomeTableViewController.swift
//  csh_Project
//
//  Created by 조서현 on 2018. 12. 9..
//  Copyright © 2018년 comsoft. All rights reserved.
//

import UIKit
import FirebaseDatabase

//내가 원하는대로 구조체 사용해서 형태 만들기
struct Shop {
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
    
}

class HomeTableViewController: UITableViewController {
    
    @IBOutlet weak var toplabel: UILabel!
    var listnum: String = ""
    
    var ref: DatabaseReference!
    var shops: [Shop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 101/255, green: 209/255, blue: 206/255, alpha: 1.0)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    //디비 연결해서 데이터 가져오기
    override func viewWillAppear(_ animated: Bool) {
        resolveShops()
    }

    //네트워크 연결해서 데이터를 가져옴
    func resolveShops() {  //데이터 읽고쓰기
        var listname: String = ""
        //예전에 가져왔던 데이터를 모두 지우고 다시 가져와야지 쌓이지 않음
        self.shops.removeAll()
        
        //옵저버로 데이터 순회하면서 내가만든 Shop형태로 데이터 넣기
        if listnum == "list1" { listname = "list1"; toplabel.text = "분식 목록"}
        else if listnum == "list2" { listname = "list2"; toplabel.text = "치킨 목록" }
        else if listnum == "list3" { listname = "list3"; toplabel.text = "피자 목록" }
        else if listnum == "list4" { listname = "list4"; toplabel.text = "패스트푸드 목록" }
        
        ref.child("shop/"+listname).observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let node = child as! DataSnapshot
                let shop = node.value as! [String: String]
                
                //데이터를 출력하기위해 데이터 준비
                var newItem = Shop()
                newItem.menuimg = shop["menuImg"]
                newItem.name = shop["name"]
                newItem.menu = shop["menu"]
                newItem.price = shop["price"]
                newItem.star = shop["star"]
                newItem.heart = shop["heart"]
                newItem.tel = shop["tel"]
                newItem.info = shop["info"]
                newItem.shopimg = shop["shopImg"]
                newItem.shopid = shop["id"]
                self.shops.append(newItem)
                print(self.shops.count)
            }
            //비동기방식으로 데이터를 가져오는 시점이테이블을 가져오고 난 시점일 수 있으므로 가져와서 반영하는 과정이 필요
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    
    
    //테이블뷰로 이미지 넣어서 데이터 불러오기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        let shop = shops[indexPath.row]
        cell.textLabel?.text = shop.name
        cell.detailTextLabel?.text = "⭐️\(shop.star!)  \(shop.menu!)"
        if let url = URL(string: shop.shopimg),
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
    
    
    var selectedCell = Shop()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            selectedCell = shops[indexPath.row]
        }
    
        let nextview = segue.destination as! HomeDetailViewController
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
