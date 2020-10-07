//
//  HistorySearchCell.swift
//  TheRestaurants
//
//  Created by ADMIN on 9/7/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import UIKit

final class HistorySearchCell: UITableViewCell {

    @IBOutlet private weak var searchKeyLabel: UILabel!

     var viewModel: HistorySearchCellModel? {
           didSet {
               updateView()
           }
    }

    private func updateView() {
           guard let viewModel = viewModel else { return }
           searchKeyLabel.text = viewModel.searchKey
    }
}
