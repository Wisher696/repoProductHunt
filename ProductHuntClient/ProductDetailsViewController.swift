//
//  ProductDetailsViewController.swift
//  ProductHuntClient
//
//  Created by Oleg Aleutdinov on 04.12.2017.
//  Copyright © 2017 Oleg Aleutdinov. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    var name: String = ""
    var votes: String = ""
    var descript: String = ""
    var thumbnaiUrl: String = ""
    var redirectUrl: String = ""
    
    @IBOutlet weak var screenImage: UIImageView!
    
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        votesLabel.text = votes
        descriptLabel.text = descript
        
        NetworkService.loadImage(url: thumbnaiUrl) { newImage in
            DispatchQueue.main.async {
                self.screenImage.image = newImage
            }
        
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getIt(_ sender: Any) {
        performSegue(withIdentifier: "goWeb", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goWeb" {
                let destVC: WebViewController = segue.destination as! WebViewController
            destVC.redirectURL = redirectUrl
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
