//
//  productTableVC.swift
//  shopifyChallenge
//
//  Created by Luna Cao on 2018/9/22.
//  Copyright © 2018年 Luna Cao. All rights reserved.
//

import UIKit

class productInfo{
    var titleName: String
    var variants:[String]
    var time: String
    var url:String
    
    init(titleName:String, variants:[String],time:String,url:String){
        self.titleName = titleName
        self.variants = variants
        self.time = time
        self.url = url
    }
    
}

class productTableVC: UITableViewController {
    
    var productInformation = [productInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("productTableCell", owner: self, options: nil)?.first as! productTableCell
        
        cell.productName.text = productInformation[indexPath.row].titleName
       
        var variantText:String = ""
        
        for variant in productInformation[indexPath.row].variants{
            variantText = variantText + " " + variant
        }
        
        cell.variants.text = variantText
        
        cell.timeSent.text = "time sent: " + productInformation[indexPath.row].time
        
        let url = URL(string:productInformation[indexPath.row].url)
        let imageData = try? Data(contentsOf: url!)
        cell.imageOne.image = UIImage(data:imageData!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productInformation.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
    
}
