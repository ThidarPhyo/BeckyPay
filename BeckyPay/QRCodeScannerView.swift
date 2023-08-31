//
//  QRCodeScannerView.swift
//  BeckyPay
//
//  Created by cmStudent on 2023/08/27.
//

import SwiftUI
import CodeScanner

struct QRCodeScannerView: View {
    @Binding var balance: Double
    @State private var scannedCode: String?
    @State private var isShowingScanner = false
    
    var body: some View {
        VStack {
            Text("Scan a QR Code")
                .font(.title)
            
            if let code = scannedCode {
                Text("Scanned Code: \(code)")
                    .font(.headline)
                    .padding()
                
                Button("Add Amount to Wallet") {
                    // Here, you would handle the payment and update the wallet balance
                    // For example, balance += someAmount
                    
                    // Clear the scanned code
                    scannedCode = nil
                }
                .font(.headline)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Button("Start Scanning") {
                    isShowingScanner = true
                }
                .font(.headline)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .sheet(isPresented: $isShowingScanner) {
                    ScannerSheet(scannedCode: $scannedCode, balance: $balance)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Scan Barcode", displayMode: .inline)
    }
}


