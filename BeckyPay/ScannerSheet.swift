//
//  ScannerSheet.swift
//  BeckyPay
//
//  Created by cmStudent on 2023/08/27.
//

import SwiftUI
import CodeScanner

struct ScannerSheet: View {
    @Binding var scannedCode: String?
    @Binding var balance: Double
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isShowingPaymentView = false
    
    var body: some View {
        CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson") { response in
            switch response {
            case .success(let result):
                scannedCode = result.string
                isShowingPaymentView = true
                print("Found code: \(result.string)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .onDisappear {
            // Clear the scanned code when the sheet is dismissed
            scannedCode = nil
        }
        .background(
            EmptyView()
                .sheet(isPresented: $isShowingPaymentView) {
                    PaymentView(scannedCode: $scannedCode, balanceAmount: $balance)
                }
        )
    }
}


