//
//  VendorsListCell.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import SwiftUI

internal struct VendorsListCell: View {
    internal var vendor: Vendor
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Text(vendor.name)
                .font(.system(size: 20, weight: .bold ))
            Text(vendor.description)
        })
    }
}

#Preview {
    VendorsListCell(vendor: .mock)
}
