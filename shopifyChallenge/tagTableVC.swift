//
//  tagTableVC.swift
//  shopifyChallenge
//
//  Created by Luna Cao on 2018/9/22.
//  Copyright © 2018年 Luna Cao. All rights reserved.
//


import UIKit
import Alamofire

class tagTableVC: UITableViewController {

    var productsArray = [AnyObject]()
    var tagArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6").responseJSON{
            response in
            
            //get all products information
            if let result = response.result.value as? Dictionary<String,AnyObject>,
                let products = result["products"]{
                self.productsArray = products as! [AnyObject]
            }
            
            //save the tags and separate them by ,
            for product in self.productsArray{
                let tag = product["tags"] as! String
                let tagArr = tag.components(separatedBy: ",")
                self.tagArray.append(contentsOf:tagArr)
            }
            
            //remove the duplicates
            self.tagArray = Array(Set(self.tagArray))
            self.tableView.reloadData()
        }
        
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
        
        let cell = Bundle.main.loadNibNamed("tagTableCell", owner: self, options: nil)?.first as! tagTableCell
        
        cell.tagLabel.text = tagArray[indexPath.row].trimmingCharacters(in: .whitespaces)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let index = tableView.indexPathForSelectedRow?.row
     let thisTag = tagArray[index!]
     var proContainsTag = [productInfo]()
     var variants = [AnyObject]()
     var imageArray = [AnyObject]()
    
      //store the selected productid
    for product in productsArray{
        let tag = product["tags"] as! String
        if (tag.range(of:thisTag) != nil){
            
            if let variantsAll = product["variants"]{
                variants = variantsAll as! [AnyObject]
            }
            
            if let imageUrl = product["images"]{
                imageArray = imageUrl as! [AnyObject]
            }
            
            var variantArr = [String]()
            for variant in variants{
                let thisVariant = variant["title"] as! String
                variantArr.append(thisVariant)
            }
            
            let firstImage = imageArray[0]["src"] as! String

            let temp = productInfo(titleName: product["title"] as! String, variants: variantArr, time: product["published_at"] as! String,url:firstImage)
            proContainsTag.append(temp)
        }
    }
    
    let viewController = storyboard?.instantiateViewController(withIdentifier: "productVC") as! productTableVC
    viewController.productInformation = proContainsTag
    
    let navC:UINavigationController = UINavigationController(rootViewController: viewController)
    let backbutton = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(goback))
    viewController.navigationItem.setLeftBarButton(backbutton, animated: true)
    
    self.present(navC,animated: true)
    }
    
    @objc func goback(){
        self.dismiss(animated: true, completion: nil)
    }
 
}
