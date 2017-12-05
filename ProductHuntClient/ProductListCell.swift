//
//  ProductListCell.swift
//  ProductHuntClient
//
//  Created by Oleg Aleutdinov on 03.12.2017.
//  Copyright © 2017 Oleg Aleutdinov. All rights reserved.
//

import Foundation
import UIKit

class ProductListCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var descript: UILabel!
    
    @IBOutlet weak var votes: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
}
