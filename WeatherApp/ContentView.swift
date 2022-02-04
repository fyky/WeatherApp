//
//  ContentView.swift
//  WeatherApp
//
//  Created by fyky on 2022/02/02.
//

import SwiftUI

struct ContentView: View {
    // 子ビューから値を渡す
    @AppStorage("city_value") var cityValue = "一宮市"
    
    //  天気の情報
    @State var info = ""
    //  気温
    @State var temperature = ""
    //  湿度
    @State var humidity = ""
    
    //  APIキー情報
    let KeyCode = ""
    
    //  天気情報取得用クラス
    var obj = WeatherModel()
    
    func GetData(data: Temperatures){
        self.info = ""
        //  温度セット(摂氏)
        self.temperature = "\(data.main.temp)°C"
        //  湿度セット
        self.humidity = "\(data.main.humidity)%"
        //  天気情報メッセージをセット
        data.weather.forEach{
            item in
            if( self.info.count == 0 )
            {
                self.info = "\n" +  item.weatherDescription + "\n"
            }
            else{
                self.info = self.info +  item.weatherDescription + "\n"
            }
        }
    }
        
    
   var body: some View {
       NavigationView {
           ZStack {
               Color("backgroundMain")
               
               VStack{
                   Text("\(cityValue)の天気情報表示")
                       .font(.title)
                   
                   Text("温度 ")
                       .padding()
                   Text("\(temperature)")
                   .padding()
                   Text("湿度 ")
                       .padding()
                   Text("\(humidity)")
                   .padding()
                   Text("情報 ")
                       .padding()
                   Text("\(info)")
                       .padding()
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
