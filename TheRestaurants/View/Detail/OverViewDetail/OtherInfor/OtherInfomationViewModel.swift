//
//  OtherInfomationViewModel.swift
//  TheRestaurants
//
//  Created by Van Le H. on 9/18/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import Foundation

final class OtherInformationViewModel {

    var highlights: [String]

    init(highlights: [String]) {
        self.highlights = highlights
    }

    func viewModelForHightlightView(at index: Int) -> HighlightViewModel {
        return HighlightViewModel(content: highlights[index])
    }
}
