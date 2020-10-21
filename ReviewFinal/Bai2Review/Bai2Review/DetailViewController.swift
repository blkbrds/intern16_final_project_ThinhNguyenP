//
//  DetailViewController.swift
//  Bai2Review
//
//  Created by ADMIN on 10/21/2563 BE.
//  Copyright © 2563 BE asiantech. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameID: UILabel!
    
    static var name: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup() {
        nameID.text = DetailViewController.name
    }
    
    
}

