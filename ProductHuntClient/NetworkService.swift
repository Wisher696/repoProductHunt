//
//  NetworkService.swift
//  ProductHuntClient
//
//  Created by Oleg Aleutdinov on 04.12.2017.
//  Copyright © 2017 Oleg Aleutdinov. All rights reserved.
//

import Foundation
import UIKit


class NetworkService {
    
    static func loadImage(url:String, clouser: @escaping (_ newImage: UIImage) ->Void) {
        var imageData: Data?
        var clearURL: String = ""
        let charDel: Character = "\\"
        
        for char in url {
            if char != charDel {
                clearURL.append(char)
            }
        }
        let url1 = URL(string: clearURL)
        print("clear", clearURL)
        var image = UIImage()
        DispatchQueue.global().async(qos: .userInitiated, flags: .barrier) {
            print("1. start \(Thread.current)")
            do {
                if let currentURL = url1 {
                    imageData = try  Data(contentsOf: currentURL)
                    print("2. dataload \(imageData)")
                }
                
            } catch{
                print("error")
            }
            DispatchQueue.global().async(qos: .userInitiated) {
                if let value =  imageData{
                    
                    print("3. image \(image)")
                    clouser(UIImage(data: value)!)
                    //                    self.thumbnaiImagelList.append(UIImage(data: value)!)
                    
                }
            }
        }
        
    }
    
}
