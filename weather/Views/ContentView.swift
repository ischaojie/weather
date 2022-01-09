//
//  ContentView.swift
//  weather
//
//  Created by 朱哲哲 on 2022/1/9.
//

import SwiftUI

struct ContentView: View {
    // location manager we defined
    // StateObject: A property wrapper type that instantiates an observable object
    // 将变量声明为 observable object
    // 变量更新时，swiftui 会自动更新 ui 中的对应属性
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    // 天气数据
    // @State 类似于 py 中的 @properity, getter & setter
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            // 获取到位置
            if let location = locationManager.location {
                // show weather
                if let weather = weather {
                    Text("ok")
                }else{
                    LoadingView().task {
                        do{
                            // try get weather
                            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                        }catch{
                            print("Error on getting weather: \(error)")
                        }
                    }
                }
            } else {
                // 还在获取中
                if locationManager.isLoading {
                    // 转圈圈
                    LoadingView()
                }else {
                    WelcomeView().environmentObject(locationManager)
                }
            }
            
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
//        首选配色方案
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
