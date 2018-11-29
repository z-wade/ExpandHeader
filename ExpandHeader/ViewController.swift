//
//  ViewController.swift
//  ExpandHeader
//
//  Created by cjz on 2018/11/29.
//  Copyright © 2018 CJZ. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let imageView = UIImageView(image: UIImage(named: "timg"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.frame = CGRect(x: 0, y: 0, width: 0, height: 190)
        tableView.expandHeaderView = imageView
    }

}

