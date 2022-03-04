//
//  UILabel+Extensions.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 03/03/22.
//

import UIKit

extension UILabel {
    func setHtmlAttributedString(with text: String, font: UIFont) {
        let modifiedFont = String(format:"<span style=\"font-family: '\(font.familyName)', 'HelveticaNeue'; font-size: \(font.pointSize)\">%@</span>", text)
        guard let data = modifiedFont.data(using: .utf8) else { self.text = text; return }
        do {
            let attrStr = try NSAttributedString(data: data, options: [.documentType : NSAttributedString.DocumentType.html, .characterEncoding : String.Encoding.utf8.rawValue], documentAttributes: nil)
            self.attributedText = attrStr
        } catch let error as NSError {
            print(error.localizedDescription)
            self.text = text
        }
    }
}
