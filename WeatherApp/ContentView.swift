//
//  ContentView.swift
//  WeatherApp
//
//  Created by fyky on 2022/02/02.
//

import SwiftUI

struct ContentView: View {
//    @State var citycount = 0
    @AppStorage("city_value") var cityValue = "一宮市"
    
   var body: some View {
       NavigationView {
           ZStack {
               Color("backgroundMain")
               
               VStack{
                       Text("\(cityValue)の天気情報表示")
               }
               
               // ナビゲーションボタン
               .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       NavigationLink(destination: SettingCityView()) {
                           Text("エリア設定").foregroundColor(.gray)
                       }
                   }
               } // .toolbarここまで
           }
       } // NavigationViewここまで
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
       ContentView()
   }
}
    
