//
//  LoadingView.swift
//  zatahub
//
//  Created by Seneca on 21/02/2024.
//

import SwiftUI

struct LoadingView: View {
    @State var isAnimating = false
    @State var circleStart: CGFloat = 0.17
    @State var circleEnd: CGFloat = 0.325
    
    @State var rotationDegree: Angle = .degrees(0)
    
    let circleTrackGradient = LinearGradient(colors: [.gray, .gray], startPoint: .top, endPoint: .bottom)
    let circleFillGradient = LinearGradient(colors: [Color(ZHColors.orange), Color(ZHColors.orange)], startPoint: .topLeading, endPoint: .trailing)
    let trackerRotation: Double = 2
    let animationDuration: Double = 0.35
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .bottom, content: {
                    Image("Logo")
                    Spacer()
                }).padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
                Spacer().frame(height: 40)
                HStack(alignment: .bottom, content: {
                    Image("img_background_2")
                        .clipped()
                    Spacer()
                })
                Spacer()
                ZStack {
                    Circle()
                        .stroke(lineWidth: 6)
                        .fill(circleTrackGradient)
                        .shadow(color: .purple.opacity(0.2), radius: 5, x: 1, y: 1)
                    
                    Circle()
                        .trim(from: circleStart, to: circleEnd)
                        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .fill(circleFillGradient)
                        .rotationEffect(rotationDegree)
                }.frame(width: 80, height: 80)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: (trackerRotation * animationDuration) + animationDuration, repeats: true) { loadingTimer in
                            self.animateLoader()
                        }
                    }
                Spacer().frame(height: 20)
                Text(AppString.pleaseWait)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color(ZHColors.strongGray2))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                Text(AppString.williamMark)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(Color(ZHColors.orange))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                Text(AppString.personalMeetingRoom)
                    .font(.system(size: 12, weight: .regular))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .foregroundColor(Color(ZHColors.strongGray2))

                HStack(alignment: .center, spacing: 0) {
                    Spacer(minLength: 0)
                    Spacer().frame(maxWidth: 160)
                    VStack(spacing: 0) {
                        Text(AppString.testSpeakerAndMicrophone)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Color(ZHColors.orange))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    }
                    Spacer(minLength: 0)
                    Image("img_background")
                }
            }.frame(width: geo.size.width, height: geo.size.height)
                .background(.white)
        }
    }
    
    private func getRotationAngle() -> Angle {
        return .degrees(360 * trackerRotation) + .degrees(120)
    }
    
    private func animateLoader() {
        withAnimation(.spring(response: animationDuration * 2)) {
            rotationDegree = .degrees(-57.5)
            circleEnd = 0.325
        }
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(.easeOut(duration: trackerRotation * animationDuration)) {
                self.rotationDegree += self.getRotationAngle()
            }
        }
        Timer.scheduledTimer(withTimeInterval: animationDuration * 1.25, repeats: false) { _ in
            withAnimation(.easeOut(duration: (trackerRotation * animationDuration) / 2.25)) {
                circleEnd = 0.95
            }
        }
        
        // reset
        Timer.scheduledTimer(withTimeInterval: trackerRotation * animationDuration, repeats: false) { _ in
            rotationDegree = .degrees(47.5)
            withAnimation(.easeOut(duration: animationDuration)) {
                circleEnd = 0.25
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
