//
//  LoginView.swift
//  zatahub
//
//  Created by Seneca on 19/02/2024.
//

import SwiftUI
import Combine

struct LoginView: View {
    @State private var textInput: String = ""
    @State private var alertVisible: Bool = false
    @State private var textFieldText: String = ""
    @State private var idValidAndShowLoading: Bool = false
    @State private var isSignUp = false
    @State private var isShowLoadingView = false
    
    var body: some View {
        if isSignUp {
            SignupView(goToLogin: {
                isSignUp = false
            })
        } else {
            if isShowLoadingView {
                LoadingView()
            } else {
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
                        HStack(spacing: 0) {
                            Image("ic_keyboard").padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 2))
                            TextField(AppString.enterMeetingId, text: $textFieldText).placeholder(when: textFieldText.isEmpty) {
                                Text(AppString.enterMeetingId)
                                    .onChange(of: textFieldText) {
                                        idValidAndShowLoading = $0.count == 7
                                    }
                            }
                            .frame(width: 200, height: 20)
                            .textFieldStyle(.plain)
                            .foregroundColor(.black)
                            .accentColor(Color.green)
                            .onReceive(Just(textFieldText)) {
                                _ in limitText(7)
                            }
                            Button(action: {
                                isShowLoadingView = true
                            }) {
                                Text(AppString.join)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(idValidAndShowLoading ? Color(ZHColors.orange) : Color(ZHColors.backgroundButton))
                            }.frame(maxWidth: 150)
                                .buttonStyle(.plain)
                                .background(idValidAndShowLoading ? Color(ZHColors.orange) : Color(ZHColors.backgroundButton))
                                .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 4))
                                .disabled(!idValidAndShowLoading)
                        }.border(Color(ZHColors.strongGray1), width: 1)
                        Spacer()
                        Image("img_with_login")
                        Spacer()
                        HStack(alignment: .center, spacing: 28) {
                            Button {
                                alertVisible = true
                            } label: {
                                Image("ic_google").renderingMode(.original)
                            }.buttonStyle(.plain)
                            
                            Button {
                                alertVisible = true
                            } label: {
                                Image("ic_apple").renderingMode(.original)
                            }.buttonStyle(.plain)
                        }
                        Spacer()
                        HStack(alignment: .center, spacing: 0) {
                            Spacer(minLength: 0)
                            Spacer().frame(maxWidth: 160)
                            Button {
                                isSignUp = true
                            } label: {
                                Text(AppString.signUp).font(.custom(zhFont: .poppinsBold, size: 15))
                                    .foregroundColor(Color(ZHColors.orange))
                            }.buttonStyle(.plain)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 14, trailing: 0))
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
    }
    
    private func limitText(_ upper: Int) {
        if textFieldText.count > upper {
            textFieldText = String(textFieldText.prefix(upper))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
