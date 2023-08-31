//
//  PaymentView.swift
//  BeckyPay
//
//  Created by cmStudent on 2023/09/01.
//

import Foundation
import SwiftUI

struct PaymentView: View {
    @Binding var scannedCode: String?
    @Binding var balanceAmount: Double

    var body: some View {
        VStack {
            Text("Payment View")
            Text("Name : \(scannedCode ?? "")")
            Text("Balance Amount is : \(balanceAmount)")
        }
    }
}
