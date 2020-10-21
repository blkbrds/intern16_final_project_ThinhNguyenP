//
//  HomeTableViewCell.swift
//  Bai2Review
//
//  Created by ADMIN on 10/21/2563 BE.
//  Copyright © 2563 BE asiantech. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameID: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var viewModel:HomeCellModel? {
        didSet {
            configView()
        }
    }
    func configView() {
        guard let viewModel = viewModel else { return }
        nameID.text = viewModel.id
    }
}
