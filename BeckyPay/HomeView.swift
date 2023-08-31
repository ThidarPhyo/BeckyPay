//
//  HomeView.swift
//  BeckyPay
//
//  Created by cmStudent on 2023/08/27.
//

import SwiftUI
import CoreImage
import CodeScanner

struct HomeView: View {
    @State private var walletBalance: Double = 100.0 // Initial balance
    @State private var qrCodeText = "Thidar Phyo"
    @State private var scannedCode: String?
    @State private var isQRCodeDisplayed = false
    @State private var isShowingScanner = false
    @State private var isPaymentViewPresented = false // To control the presentation of the PaymentView
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Payment App!")
                    .font(.title)
                
                Text("Wallet Balance: $\(walletBalance)")
                    .font(.headline)
                    .padding()
                
                Button("Scan QR Code") {
                    isShowingScanner = true
                }
                .font(.headline)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .sheet(isPresented: $isShowingScanner) {
                    ScannerSheet(scannedCode: $scannedCode, balance: $walletBalance)
                }
                Spacer()
                Text("QR Code Generator")
                    .font(.title)
                
                TextField("Enter text", text: $qrCodeText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Generate QR Code") {
                    isQRCodeDisplayed = true
                }
                .font(.headline)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                if isQRCodeDisplayed {
                    SquareQRCodeView(qrCodeText: qrCodeText)
                }
                
                Spacer()
            }
        }
    }
    
    // Rest of the code remains the same...
}

struct SquareQRCodeView: View {
    var qrCodeText: String
    
    var body: some View {
        if let qrCodeImage = generateQRCodeImage(from: qrCodeText, size: CGSize(width: 200, height: 200)) {
            Image(uiImage: qrCodeImage)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
        } else {
            Image(systemName: "xmark.circle")
        }
    }
    
    func generateQRCodeImage(from text: String, size: CGSize) -> UIImage? {
        let data = text.data(using: .utf8)
        guard let qrCode = generateQRCode(from: data) else {
            return nil
        }
        
        let context = CIContext()
        if let cgImage = context.createCGImage(qrCode, from: qrCode.extent) {
            return UIImage(cgImage: cgImage)
        } else {
            return nil
        }
    }
    
    func generateQRCode(from data: Data?) -> CIImage? {
        guard let data = data,
              let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")
        return filter.outputImage
    }
    
    // ... rest of the code remains the same ...
}


