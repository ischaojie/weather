//
//  LocationManager.swift
//  weather
//
//  Created by 朱哲哲 on 2022/1/9.
//

import Foundation

//位置
import CoreLocation

//NSObject: The root class of most Objective-C class hierarchies
//ObservableObject: A type of object with a publisher that emits before the object has changed.
// 保证所有 @published 的变量的更新可以同步
//CLLocationManagerDelegate: 位置管理接口
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D? // ?可选
    @Published var isLoading = false // 是否加载坐标
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    // 实现location接口方法
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate // 获取当前location坐标
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
}
