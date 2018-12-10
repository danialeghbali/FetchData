//
//  FetchData.swift
//  FetchData
//
//  Created by danial eghbali on 12/10/18.
//  Copyright © 2018 danial eghbali. All rights reserved.
//

import UIKit

class FetchData {

    var cachImage:[String:UIImage]=[:]
    
    func getImage(img:UIImageView,_url:String){
        
        
        if self.cachImage[_url] != nil
        {
        DispatchQueue.main.async() {
            img.image = self.cachImage[_url]
        }
        }
        else{
        let url = URL(string: _url)!
        let request = URLRequest(url: url)
        
            let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                //let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                
                else { return }
            DispatchQueue.main.async() {
                img.image = image
            }
        }
        task.resume()
        }
        
    }
    
    }

