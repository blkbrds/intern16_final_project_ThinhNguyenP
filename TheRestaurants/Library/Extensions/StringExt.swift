//
//  StringExt.swift
//  TheRestaurants
//
//  Created by Van Le H. on 8/24/20.
//  Copyright © 2020 Thinh Nguyen P[6] All rights reserved.
//

import UIKit

extension String {

    /// Initializes an NSURL object with a provided URL string. (read-only)
    public var url: URL? {
        return URL(string: self)
    }

    /// The host, conforming to RFC 1808. (read-only)
    public var host: String {
        if let url = url, let host = url.host {
            return host
        }
        return ""
    }

    func contentWidth(font: UIFont) -> CGFloat {
        let size = (self as NSString).size(withAttributes: [.font: font])
        return size.width
    }

    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    func addLineSpacing(_ lineSpacing: CGFloat, alingment: NSTextAlignment = .left) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = lineSpacing
        paragraph.alignment = alingment
        return NSAttributedString(string: self, attributes: [.paragraphStyle: paragraph])
    }
}
