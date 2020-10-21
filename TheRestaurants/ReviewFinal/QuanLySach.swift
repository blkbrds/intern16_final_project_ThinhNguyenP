//
//  ThuVien.swift
//  TheRestaurants
//
//  Created by ADMIN on 10/21/2563 BE.
//  Copyright © 2563 BE Thinh Nguyen P[6]. All rights reserved.
//

import Foundation

class QuanLySach {
    var cacLoaiSach: [Sach]
    var cacLoaiBao: [Bao]
    var cacLoaiTapChi: [TapChi]
    init(cacLoaiSach: [Sach], cacLoaiBao: [Bao], cacLoaiTapChi: [TapChi]) {
        self.cacLoaiBao = cacLoaiBao
        self.cacLoaiTapChi = cacLoaiTapChi
        self.cacLoaiSach = cacLoaiSach
    }

    func themMoiSach(sachThem: Sach) {
        cacLoaiSach.append(sachThem)
    }
    func themMoiTapChi(tapChiThem: TapChi) {
        cacLoaiTapChi.append(tapChiThem)
    }
    func themMoiBao(baoThem: Bao) {
        cacLoaiBao.append(baoThem)
    }
    
    func xoaTaiLieu(maTaiLieu: Int) {
        for item in cacLoaiSach {
            if item.maTaiLieu == maTaiLieu {
                cacLoaiSach.remove(at: item.maTaiLieu)
            }
        }
        for item in cacLoaiTapChi {
            if item.maTaiLieu == maTaiLieu {
                cacLoaiTapChi.remove(at: item.maTaiLieu)
            }
        }
        for item in cacLoaiBao {
            if item.maTaiLieu == maTaiLieu {
                cacLoaiBao.remove(at: item.maTaiLieu)
            }
        }
    }
    func timKiemTaiLieu(maTaiLieu: Int) {
        for item in cacLoaiSach {
            if item.maTaiLieu == maTaiLieu {
                print(item.tenNhaXuatBan )
            }
        }
        for item in cacLoaiBao {
            if item.maTaiLieu == maTaiLieu {
                print(item.tenNhaXuatBan  )
            }
        }
        for item in cacLoaiTapChi {
            if item.maTaiLieu == maTaiLieu {
                print(item.tenNhaXuatBan )
            }
        }
    }
}
