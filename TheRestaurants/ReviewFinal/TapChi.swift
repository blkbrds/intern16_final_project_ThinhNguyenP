//
//  TapChi.swift
//  TheRestaurants
//
//  Created by ADMIN on 10/21/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class TapChi: TaiLieu {
    var soPhatHanh: Int
    var thangPhatHanh: Int
    init(soPhatHanh: Int, thangPhatHanh: Int, maTaiLieu: String, tenNhaXuatBan: String, soBanPhatHanh: String) {
        self.soPhatHanh = soPhatHanh
        self.thangPhatHanh = thangPhatHanh
        super.init(maTaiLieu: maTaiLieu, tenNhaXuatBan: tenNhaXuatBan, soBanPhatHanh: soBanPhatHanh)
    }
}
