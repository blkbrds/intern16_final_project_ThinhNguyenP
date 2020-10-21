//
//  MaTaiLieu.swift
//  TheRestaurants
//
//  Created by ADMIN on 10/21/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class TaiLieu {
    var maTaiLieu: Int
    var tenNhaXuatBan: String
    var soBanPhatHanh: String
    init(maTaiLieu: Int, tenNhaXuatBan: String, soBanPhatHanh: String) {
        self.maTaiLieu = maTaiLieu
        self.tenNhaXuatBan = tenNhaXuatBan
        self.soBanPhatHanh = soBanPhatHanh
    }
    func thongTinTaiLieu() {
        print("\(maTaiLieu) cua nha xuat ban \(tenNhaXuatBan) co so ban phat hanh \(soBanPhatHanh)")
    }
}
