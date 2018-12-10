//
//  ViewController.swift
//  FetchData
//
//  Created by danial eghbali on 12/8/18.
//  Copyright © 2018 danial eghbali. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
     let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableProduct: UITableView!
    var data:[[String:Any]] = []
    //let fetchData=FetchData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableProduct.dataSource=self
        self.tableProduct.delegate=self
        
       
        self.tableProduct.addSubview(refreshControl)
        refreshControl.tintColor = UIColor(red:1.0, green:0.0, blue:0.0, alpha:1.0)
        
        
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
       getData(_url: "http://pastebin.com/raw/wgkJgazE")
       
    }

    func reloadData()
    {
       
        getData(_url: "http://pastebin.com/raw/wgkJgazE")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return data.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:TableViewCell = self.tableProduct.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
      let obj=data[indexPath.row]
        cell.lblProductName.text=obj["username"] as? String
        let _url=(obj["profile_image"] as! [String:String])["large"]!
        
       
    
        FetchData().getImage(img: cell.imgProductImage, _url: _url)
        
 
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            getData(_url: "http://pastebin.com/raw/wgkJgazE")
        }
    }
    
    
    func getData( _url:String){
        
        
        
        let url = URL(string: _url)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        //request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Empty")
                return
            }
            
            DispatchQueue.main.async {
                
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [Any] {
                    
                    for item in responseJSON
                    {
                        let obj = item as! [String:Any]
                        self.data.append((obj["user"] as! [String:Any]))
                        
                    }
                    
                    self.tableProduct.reloadData()
                    self.refreshControl.endRefreshing()
                  
                }
                
            }
        }
        
        task.resume()
    }
     
   }


