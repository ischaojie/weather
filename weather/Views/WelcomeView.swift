//
//  WelcomeView.swift
//  weather
//
//  Created by 朱哲哲 on 2022/1/9.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    //A property wrapper type for an observable object supplied by a parent or ancestor view
    // 对应父视图 ContentView 中的 locationManager，将其传入当前 view
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("天气之子")
                    .font(.title).bold()
                
                Text("分享位置以获取当前天气").padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            //分享位置按钮：其中请求位置
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        
        
        // 限制视图框架大小
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
