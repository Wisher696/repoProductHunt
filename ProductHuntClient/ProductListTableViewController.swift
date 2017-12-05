//
//  ViewController.swift
//  ProductHuntClient
//
//  Created by Oleg Aleutdinov on 02.12.2017.
//  Copyright © 2017 Oleg Aleutdinov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProductListTableViewController: UITableViewController {
    var nameList: [String] = []
    var votesList: [String] = []
    var descriptList: [String] = []
    var thumbnaiUrllList: [String] = []
    var redirectUrllList: [String] = []
    
    fileprivate func loadJSON(category: String) {
        //        let url = "https://httpbin.org/get"
        //            {
        //                "client_id" : "e2a1a3259b4e13eb324bed61340b546664670e648a62d7d36e59cad11e394db7",
        //                "client_secret" : "ba2ab029005f6468580b52e0c5e3a558f327a15749fd3475351a256fc013d259",
        //                "grant_type" : "client_credentials"
        //        }
        let parameters: Parameters = [
            "client_id": "aadcd4403bc6c9e66ae80025dcf6660240d17947f845af0f2d4abb57dcd55de6",
            "client_secret": "d0ab6a069fe8c281c97739797e7fafe3a127aa865b752aea26369d6ee8fdcd4b",
            "grant_type": "client_credentials"
        ]
        let urlProductList = "https://api.producthunt.com/v1/oauth/token"
        Alamofire.request(urlProductList, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(queue: DispatchQueue.global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                let url = "https://api.producthunt.com/v1/posts/all?search[category]=\(category)&access_token=\(json["access_token"].stringValue)"
                Alamofire.request(url, method: .get).validate().responseJSON(queue: DispatchQueue.global()) { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        for (_,subJSON) in json["posts"] {
                            
                            self.nameList.append(subJSON["name"].stringValue)
                            self.votesList.append(subJSON["votes_count"].stringValue)
                            self.descriptList.append(subJSON["tagline"].stringValue)
                            self.thumbnaiUrllList.append(subJSON["thumbnail"]["image_url"].stringValue)
                            self.redirectUrllList.append(subJSON["redirect_url"].stringValue)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                        print("JSON: \(json)")
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJSON(category: "tech")
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func changeCategory(segue: UIStoryboardSegue) {
        
        // Проверяем идентификатор перехода, чтобы убедится, что это нужный переход
        if segue.identifier == "change" {
            // Получаем ссылку на контроллер, с которого осуществлен переход
            let changeController = segue.source as! ChangeCategoryTableViewController
            
            // получаем индекс выделенной ячейки
            if let indexPath = changeController.tableView.indexPathForSelectedRow {
                // получаем город по индексу
                let category = changeController.categoryList[indexPath.row]
                nameList = []
                votesList = []
                descriptList = []
                thumbnaiUrllList = []
                redirectUrllList = []
                // добавляем город в список выбранных городов
                loadJSON(category: category)
                // обновляем таблицу

            }
            
        }

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductListCell
        cell.name.text = nameList[indexPath.row]
        cell.votes.text = votesList[indexPath.row]
        cell.descript.text = descriptList[indexPath.row]
        NetworkService.loadImage(url: thumbnaiUrllList[indexPath.row]) { newImage in
            DispatchQueue.main.async {
                    cell.icon.image = newImage
            }

        }
//        cell.icon.image = thumbnaiImagelList[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getIt" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destVC: ProductDetailsViewController = segue.destination as! ProductDetailsViewController
                destVC.name = nameList[indexPath.row]
                destVC.descript = descriptList[indexPath.row]
                destVC.thumbnaiUrl = thumbnaiUrllList[indexPath.row]
                destVC.votes = votesList[indexPath.row]
                destVC.redirectUrl = redirectUrllList[indexPath.row]
            }
        }
    }
    
}

