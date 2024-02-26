//
//  InstallView.swift
//  ZataHub
//
//  Created by Macbook on 26/01/2024.
//

import SwiftUI

struct InstallView: View {
    @State private var languageOptions = 0
    @State private var selectedLocationIndex = "Default Location"
    @State private var selectedFolder: URL?
    @State var isVerify = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    @State private var isShowPopup: Bool = false
    @State var percentInstall = 0.0
    static var maxPercentInstall: Int = 22
    let choiceLanguage = ["English (North America)", "English (Middle East)", "Español", "Español (América Latina)", "Suomi","Français canadien", "Français (Maroc)", "Français Oriental Moyen","עִברִית", "Magyar","Italiano", "日本語", "한국어","Norsk (Bokmål)", "Nederlands", "Norwegian", "Svenska", "Türkçe","Українська", "简体中文", "繁體中文"]
    @State var choiceLocations = ["Default Location", "Change Location..."]
    private var appVersion: String {
        if let infoDict = Bundle.main.infoDictionary {
            // Get the app version
            return (infoDict["CFBundleShortVersionString"] as? String) ?? "1.0.0"
        }
        return "1.0.0"
    }

    private var productName: String {
        if let infoDict = Bundle.main.infoDictionary {
            // Get the app version
            return (infoDict["CFBundleName"] as? String) ?? "ZataHub"
        }
        return "ZataHub"
    }

    var body: some View {
        HostingWindowFinder { window in
            window?.standardWindowButton(.zoomButton)?.isHidden = true
        }
        VStack(spacing: 0) {
            VStack(spacing: 2) {
                if isVerify {
                    Text("Installing(\(Int(percentInstall))%)")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .padding(.leading, -48)
                        .multilineTextAlignment(.trailing)

                    Text("ESTIMATING TIME REMAINING")
                        .foregroundColor(Color.gray)
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                        .padding(.leading, 20)
                } else {
                    Text("Installation")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .padding(.leading, 17)

                    Text("OPTIONS")
                        .foregroundColor(Color.gray)
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                        .padding(.leading, -5)
                }

            }
            .frame(width: 420, height: 59, alignment: .leading)
            .background(Color("black"))
            ProgressView(value: percentInstall, total: 100)
                .frame(width: 432)
                .offset(y: -7)
                .onReceive(timer) { _ in
                    if isVerify {
                        if percentInstall < Double(InstallView.maxPercentInstall) {
                            percentInstall += 1
                        }
                    } else {
                        percentInstall = 0
                    }
                }

            VStack(spacing: 0) {
                Image("ic_app")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .sheet(isPresented: $isShowPopup, content: {
                        LoginAuthView(isVerify: $isVerify)
                    })

                Text(productName + " - Online Meeting Platform")
                    .fontWeight(.regular)
                    .font(.system(size: 20))
                    .padding(.top)

                Text("Version \(appVersion)")
                    .padding(.top, 2)
            }
            .frame(width: 428, height: 300)
            .background( isVerify ? Color("white") : Color("gray5"))
            if isVerify {
                VStack(spacing: 10) {
                    Image("ic_active")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34, height: 44)
                        .padding(.top)
                    Text("Creative Cloud gives you the world's best \ncreative apps")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .font(.system(size: 14))
                    Button(action: {
                        //TODO: Learn more
                    }) {
                        VStack {
                            Text("Learn more")
                                .fontWeight(.semibold)
                                .frame(height: 20)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(BlueButtonStyle())

                }
                .frame(maxWidth: .infinity)
                .frame(height: 230, alignment: .top)
                .background(Color("gray5"))
            } else {
                VStack(spacing: 10) {
                    Text("Installation Options")
                        .fontWeight(.regular)
                        .font(.system(size: 16))
                    Divider().frame(width: 230)
                    HStack {
                        Text("Language:")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .frame(width: 230)
                    Picker("", selection: $languageOptions) {
                        ForEach(0..<choiceLanguage.count) { index in
                            Text(choiceLanguage[index])
                                .tag(index)
                        }

                    }
                    .frame(width: 250)
                    .scaleEffect(CGSize(width: 1, height: 1.1))
                    HStack {
                        Text("Location:")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.top, 7)
                    .frame(width: 230)
                    Picker("", selection: $selectedLocationIndex) {
                        ForEach(choiceLocations, id: \.self) { location in
                            Text(location)
                                .tag(location)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 250)
                    .scaleEffect(CGSize(width: 1, height: 1.1))
                    .onChange(of: selectedLocationIndex) { newValue in
                        if newValue == "Change Location..." {
                            let panel = NSOpenPanel()
                            panel.title = "Select Save Path"
                            panel.canChooseFiles = false
                            panel.canChooseDirectories = true
                            panel.allowsMultipleSelection = false
                            panel.canCreateDirectories = true
                            panel.showsHiddenFiles = false

                            switch panel.runModal() {
                            case .OK:
                                selectedFolder = panel.urls.first
                                var path = selectedFolder?.path ?? ""
                                if !choiceLocations.contains(path) {
                                    choiceLocations.append(path)
                                }
                                if let lastElement = choiceLocations.last {
                                    print("Array is: \( choiceLocations)")
                                    print("Last item is:  \(lastElement)")
                                    selectedLocationIndex = lastElement
                                } else {
                                    break
                                }
                            case .cancel:
                                selectedLocationIndex = choiceLocations[0]
                            default:
                                break
                            }
                        }
                    }
                    Button(action: {
                        isShowPopup.toggle()
                    }) {
                        VStack {
                            Text("Continue")
                                .fontWeight(.semibold)
                                .frame(width: 70, height: 20)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(BlueButtonStyle())

                }
                .offset(y: -30)
            }
            Spacer().frame(height: isVerify ? 0 : 33)
        }
        .frame(width: 420, height: 600, alignment: .top)
        .background(isVerify ? Color("white") : Color.clear)
        .preferredColorScheme(.light)
    }
}

struct HostingWindowFinder: NSViewRepresentable {
    var callback: (NSWindow?) -> ()

    func makeNSView(context: Self.Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async { [weak view] in
            self.callback(view?.window)
        }
        return view
    }
    func updateNSView(_ nsView: NSView, context: Context) {}
}

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.blue : Color.white)
            .frame(width: 90)
            .background(configuration.isPressed ? Color.white : Color.blue)
            .cornerRadius(3.0)
            .padding(.horizontal)
            .padding(.vertical)
    }
}

#Preview {
    InstallView()
}
