//
//  SettingCityView.swift
//  WeatherApp
//
//  Created by fyky on 2022/02/03.
//

import SwiftUI

struct SettingCityView: View {
    @AppStorage("city_value") var cityValue = "一宮市"
    
    var body: some View {
        ZStack {
            Color("backgroundMain")
//            Color.blue
            
            VStack {
                Text("エリアを設定")
                    .font(.title)
                
                Spacer()
                
                Text("選んだのは：\(cityValue)")
                    .font(.title)
                
                Spacer()
                
                Picker(selection: $cityValue) {
                    Text("一宮市")
                        .tag("一宮市")
                    Text("名古屋市")
                        .tag("名古屋市")
                } label: {
                    Text("選択")
                }
                .pickerStyle(.wheel)
            }
        }
    }
}

struct SettingCityView_Previews: PreviewProvider {
    static var previews: some View {
        SettingCityView()
    }
}
