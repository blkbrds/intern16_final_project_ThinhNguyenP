//
//  Sach.swift
//  TheRestaurants
//
//  Created by ADMIN on 10/21/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class Sach: TaiLieu {
    var tenTacGia: String
    var soTrang: Int
    init(tenTacGia: String, soTrang: Int, maTaiLieu: String, tenNhaXuatBan: String, soBanPhatHanh: String) {
        self.tenTacGia = tenTacGia
        self.soTrang = soTrang
        super.init(maTaiLieu: maTaiLieu, tenNhaXuatBan: tenNhaXuatBan, soBanPhatHanh: soBanPhatHanh)
    }
}
