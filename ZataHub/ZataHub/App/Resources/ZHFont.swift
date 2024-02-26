//
//  ZHFont.swift
//  zatahub
//
//  Created by Seneca on 19/02/2024.
//

import SwiftUI

enum ZHFont: String {
    case calibriRegular = "Calibri"
    case calibriLight = "Calibri-Light"
    case calibriLightItalic = "Calibri-LightItalic"
    case calibriItalic = "Calibri-Italic"
    case calibriBoldItalic = "Calibri-BoldItalic"
    case poppinsRegular = "Poppins-Regular"
    case poppinsLight = "Poppins-Light"
    case poppinsMedium = "Poppins-Medium"
    case poppinsSemiBold = "Poppins-SemiBold"
    case poppinsBold = "Poppins-Bold"
}

extension Font {
    static func custom(zhFont: ZHFont, size: CGFloat) -> Font {
        return custom(zhFont.rawValue, size: size)
    }
}
