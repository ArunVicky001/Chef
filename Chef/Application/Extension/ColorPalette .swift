//
//  ColorPalette .swift
//  TeachOS
//
//  Created by Bhagyashree Myanamwar on 10/7/21.
//

import UIKit

extension UIColor {
    
    static let topprBlue: UIColor = UIColor(hex: "55BBEA")
    static let topprGray: UIColor = UIColor(red: 0.298, green: 0.298, blue: 0.298, alpha: 1)
    static let topprGreen: UIColor = UIColor(red: 0.37647, green: 0.72549, blue: 0.1215686275, alpha: 1)
    static let errorColor: UIColor = UIColor(red: 0.89, green: 0.4196, blue: 0.443, alpha: 1)
    static let redF36D6D: UIColor = UIColor(hex: "#F36D6D")
    static let redFA6400: UIColor = UIColor(hex: "FA6400")
    static let green60B91F: UIColor = UIColor(hex: "#60b91f")
    static let acceptedGreen: UIColor = UIColor(hex: "#417505")
    static let hex959595: UIColor = UIColor(hex: "959595")
    static let hexFD6F6F: UIColor = UIColor(hex: "FD6F6F")
    static let hexF1FFE6: UIColor = UIColor(hex: "F1FFE6")
    static let hexF7F7F7: UIColor = UIColor(hex: "F7F7F7")
    static let hexF2FBFF: UIColor = UIColor(hex: "F2FBFF")
    static let hexE5635B: UIColor = UIColor(hex: "E5635B")
    static let hexFFF4F4: UIColor = UIColor(hex: "FFF4F4")
    static let shadesCharcoal: UIColor = UIColor(hex: "#181824")
    static let hex6A6A86: UIColor = UIColor(hex: "#6A6A86")
    static let hexF0F0F1: UIColor = UIColor(hex: "F0F0F1")
    static let lightGray1: UIColor = UIColor(hex: "F2F4FB")
    static let grey100: UIColor = UIColor(hex: "F4F5F7")
    static let grey200: UIColor = UIColor(hex: "CECED7")
    static let charcoalGrey: UIColor = UIColor(hex: "9C9CAE")
    static let grey300: UIColor = UIColor(hex: "676D7C")
    static let black100: UIColor = UIColor(hex: "2C2C2C")
    static let green100: UIColor = UIColor(hex: "E8FFF8")
    static let green200: UIColor = UIColor(hex: "26D8A2")
    static let green300: UIColor = UIColor(hex: "14C28E")
    static let green400: UIColor = UIColor(hex: "0B987C")
    static let yellow1: UIColor = UIColor(hex: "FEF1DD")
    static let yellowTest: UIColor = UIColor(hex: "FFA620")
    static let lightBlue1: UIColor = UIColor(hex: "F2F7FF")
    static let hex6393F0: UIColor = UIColor(hex: "6393F0")
    static let blue100: UIColor = UIColor(hex: "4870FF")
    static let blue200: UIColor = UIColor(hex: "2152FF")
    static let blue300: UIColor = UIColor(hex: "060031")
    static let lightRed: UIColor = UIColor(hex: "FFF2F2")
    static let pinkLecture: UIColor = UIColor(hex: "FC7E95")
    static let red100: UIColor = UIColor(hex: "F65253")
    static let red200: UIColor = UIColor(hex: "FC5473")
    static let red300: UIColor = UIColor(hex: "FD054F")
    static let hexECF2FD: UIColor = UIColor(hex: "ECF2FD")
    static let dropShadow: UIColor = UIColor(hex: "2D2D31")
    
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

