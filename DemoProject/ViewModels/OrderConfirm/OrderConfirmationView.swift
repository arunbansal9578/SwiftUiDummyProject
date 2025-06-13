//
//  OrderConfirmationPopup.swift
//  DemoProject
//
//  Created by Arun Kumar on 12/06/25.
//

import SwiftUI

struct OrderConfirmation: View {
    
    @Binding var isPresented: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack{
            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
                
                Text("Hey Customer")
                    .font(.subheadline)
                
                Text("Your Order is Confirmed!")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("We’ll send you a shipping confirmation email as soon as your order ships.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    // Optional: Add button action
                    dismiss()
                }) {
                    Text("Order More?")
                        .font(.caption)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .fontWeight(.bold)
                }
                .padding(.horizontal, 24)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 10)
            .frame(maxWidth: 300, maxHeight: UIScreen.main.bounds.height)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        dismiss()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
