//
//  Color+.swift
//  zatahub
//
//  Created by Seneca on 19/02/2024.
//


import SwiftUI

extension Color {
    init(_ zhColor: ZHColors) {
        self.init(zhColor.rawValue)
    }
}
