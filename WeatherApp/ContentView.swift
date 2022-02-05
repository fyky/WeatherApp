//
//  ContentView.swift
//  WeatherApp
//
//  Created by fyky on 2022/02/02.
//

import SwiftUI

struct ContentView: View {
    
    // 子ビューから値を渡す
    @AppStorage("city_value") var cityValue = "Tokyo"
    
   //  天気情報
   @State var result = ""
   //  気温
   @State var temp = ""
   //  湿度
   @State var humidity = ""
    
    
//   //  天気情報を取得する場所
//   let cityValue = "Tokyo"
//
//
    
   //  キー情報
   let KeyCode = "*****"
   //  天気情報取得用クラス
   var obj = WeatherModel()

   //  取得した天気情報を処理
    func GetData(data: Temperatures){
       self.result = ""
       //  温度をセット(摂氏)
       self.temp = "\(data.main.temp)°C"
       //  湿度をセット
        self.humidity = "\(data.main.humidity)%"
       //  天気情報メッセージ
        data.weather.forEach{
           item in
           if( self.result.count == 0 )
           {
               self.result = item.weatherDescription
           }
           else{
               self.result = self.result +  item.weatherDescription + "\n"
           }
       }
   }
   var body: some View {
       NavigationView {
           VStack{
               //  天気取得用
               Button(action:{
                   var invokeURL = ""

                       invokeURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityValue),jp&appid=\(self.KeyCode)&lang=ja&units=metric"

                   //  天気情報を取得(APIコール)
                   self.obj.getWeather(invoke_url: invokeURL, action: self.GetData)
               })
               {
                   HStack{
                       Text("\(cityValue)")

                       Text("今日の天気は?")
                       .padding()
                       .border(Color.black)
                   }
               }
               HStack{
                   Text("天気 ")
                       .padding()
                   Text("\(result)")
                   .padding()
               }
               HStack{
                   Text("気温 ")
                       .padding()
                   Text("\(temp)")
                   .padding()
               }
               HStack{
                   Text("湿度 ")
                       .padding()
                   Text("\(humidity)")
                   .padding()
               }
               
               // ナビゲーションボタン
               .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       NavigationLink(destination: SettingCityView()) {
                           Image("settingArea")
                           Text("エリア設定").foregroundColor(.gray)
                       }
                   }
               } // .toolbarここまで
               
           }
       } // navigationviewここまで
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
       ContentView()
   }
}
