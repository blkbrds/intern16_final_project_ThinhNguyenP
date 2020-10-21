//
//  Bao.swift
//  TheRestaurants
//
//  Created by ADMIN on 10/21/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class Bao: TaiLieu {
    var ngayPhatHanh: Int
    init(ngayPhatHanh: Int, maTaiLieu: String, tenNhaXuatBan: String, soBanPhatHanh: String) {
        self.ngayPhatHanh = ngayPhatHanh
        super.init(maTaiLieu: maTaiLieu, tenNhaXuatBan: tenNhaXuatBan, soBanPhatHanh: soBanPhatHanh)
    }
}
