//
//  SignupView.swift
//  zatahub
//
//  Created by Seneca on 19/02/2024.
//

import SwiftUI

struct SignupView: View {
    @State private var isSignUp = false // switch signup and login
    
    @State private var textInput: String = ""
    @State private var alertVisible: Bool = false
    @State private var textFieldText: String = ""
    @State private var meetingIdValid: Bool = false
    var goToLogin: () -> Void
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .bottom, content: {
                    Image("Logo")
                    Spacer()
                }).padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                HStack(alignment: .bottom, content: {
                    Image("img_background_2")
                        .clipped()
                    Spacer(minLength: 0)
                    Image("zatahub")
                        .clipped()
                    Spacer().frame(maxWidth: 170)
                    Spacer()
                })
                Spacer()
                Button {
                    alertVisible = true
                } label: {
                    Image("SignUpWithApple").renderingMode(.original)
                }.buttonStyle(.plain)
                
                Button {
                    alertVisible = true
                } label: {
                    Image("SignUpWithGoogle").renderingMode(.original)
                }.buttonStyle(.plain).padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                
                HStack(alignment: .center, spacing: 0) {
                    Spacer(minLength: 0)
                    Spacer().frame(maxWidth: 160)
                    VStack(spacing: 0) {
                        Text(AppString.alreadyHaveAccount)
                            .font(.custom(zhFont: .calibriBoldItalic, size: 15))
                            .foregroundColor(Color(ZHColors.strongGray1))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        Button {
                            goToLogin()
                        } label: {
                            Text(AppString.login).foregroundColor(Color(ZHColors.orange))
                                .font(.custom(zhFont: .calibriRegular, size: 15))
                        }.buttonStyle(.plain)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 14, trailing: 0))
                    }
                    Spacer(minLength: 0)
                    Image("img_background")
                }
            }.frame(width: geo.size.width, height: geo.size.height)
                .background(.white)
                .alert(AppString.sorryThisFeatureHasBeen, isPresented: $alertVisible) {
                    Button(AppString.ok, role: .cancel) { }
                }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(goToLogin: {})
    }
}
