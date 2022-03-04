//
//  UILabel+Extensions.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 03/03/22.
//

import UIKit

extension UILabel {
    func setHtmlAttributedString(with text: String, font: UIFont) {
        let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(font.pointSize)\">%@</span>", text)
        
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        self.attributedText = attrStr
    }
    
    func attributedText(withString string: String, boldString: String, font: UIFont) {
        let attributedString = NSMutableAttributedString(string: string,
                                                     attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        self.attributedText = attributedString
    }
}
