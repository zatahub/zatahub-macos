//
//  LoginView.swift
//  ZataHub
//
//  Created by Macbook on 26/01/2024.
//

import SwiftUI

struct LoginAuthView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isAnimation: Bool = false
    @State var isShowBorder = false
    @Environment(\.presentationMode) var presentationMode
    let userName = NSFullUserName()
    @Binding var isVerify: Bool

    var body: some View {
        ZStack {
            VStack {
                Image("ic_app")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                Text(Bundle.main.bundleIdentifier ?? "")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                Text("\(Bundle.main.bundleIdentifier ?? "") wants to \n make changes")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                    .padding(.top, 5)
                Text("Enter your password to allow this.")
                    .foregroundColor(Color.white)
                    .padding(.top, 10)
                VStack {
                    TextField("\(userName)", text: $email)
                        .padding()
                        .focusable(false)
                        .frame(height: 25)
                        .foregroundColor(.white)
                        .brightness(0.60)
                        .background(Color("gray")).opacity(0.5)
                        .cornerRadius(5.0)
                        .padding(.horizontal)
                        .textFieldStyle(PlainTextFieldStyle())
                    SecureField("Password", text: $password)
                        .focusable(true)
                        .padding()
                        .frame(height: 25)
                        .background(Color("gray")).opacity(0.5)
                        .cornerRadius(5.0)
                        .foregroundColor(.white)
                        .textContentType(.password)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( isShowBorder ? Color.blue.opacity(0.8) : Color.clear, lineWidth: 4)
                        )
                        .padding(.horizontal)
                        .textFieldStyle(PlainTextFieldStyle())

                }

                HStack(spacing: -25) {

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        VStack {
                            Text("Cancel")
                                .fontWeight(.regular)
                                .frame(maxWidth: .infinity)

                        }

                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .background(Color("gray4"))
                    }

                    .buttonStyle(MacButtonStyles())

                    Button(action: {
                        // TODO: somthing when click button Ok
                        if isVerify {
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            isAnimation = true
                            isShowBorder = true
                            withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                                isAnimation = false
                            }
                        }
                    }) {
                        VStack {
                            Text("OK")
                                .fontWeight(.regular)
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color("blue1"), Color("blue")]), startPoint: .top, endPoint: .bottom)
                        )

                    }
                    .buttonStyle(MacButtonStyles())

                }
                .frame(height: 30)
                .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                email = "\(userName)"
            }

        }
        .offset(x: isAnimation ? 30 : 0)
        .frame(width: 280, height: 350)
        .background( LinearGradient(
            gradient: Gradient(colors: [Color.clear, Color.clear]),
            startPoint: .top,
            endPoint: .bottom
        ))
        .preferredColorScheme(.dark)
    }
}
