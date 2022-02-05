//
//  ContentView.swift
//  WeatherApp
//
//  Created by fyky on 2022/02/02.
//

import SwiftUI
extension Color {
    static let customeColor = Color("link")
}

struct ContentView: View {

    let date = Date.now
    
    // 子ビューから値を渡す
    @AppStorage("city_value") var cityValue = "Ichinomiya"
    
   //  天気情報
   @State var result = ""
   //  気温
   @State var temp = ""
   //  湿度
   @State var humidity = ""
    
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
           ZStack {
               Color("area")
                   .ignoresSafeArea()
               
               VStack {
                   if (cityValue == "Nagoya"){
                       Text("現在の愛知県名古屋市")
                           .foregroundColor(.white)
                           .font(.title)
                           .frame(maxWidth: .infinity, alignment: .top)
                           .padding(EdgeInsets(
                               top: 60,
                               leading: 0,
                               bottom: 60,
                               trailing: 0
                           ))
                           .background(Color("backgroundMain"))
                   } else if (cityValue == "Ichinomiya") {
                       Text("現在の愛知県一宮市")
                           .foregroundColor(.white)
                           .font(.title)
                           .frame(maxWidth: .infinity, alignment: .top)
                           .padding(EdgeInsets(
                               top: 60,
                               leading: 0,
                               bottom: 60,
                               trailing: 0
                           ))
                           .background(Color("backgroundMain"))
                   } else if (cityValue == "Tokyo") {
                       Text("現在の東京都")
                           .foregroundColor(.white)
                           .font(.title)
                           .frame(maxWidth: .infinity, alignment: .top)
                           .padding(EdgeInsets(
                               top: 60,
                               leading: 0,
                               bottom: 60,
                               trailing: 0
                           ))
                           .background(Color("backgroundMain"))
                   } else {
                       Text("現在の大阪府")
                           .foregroundColor(.white)
                           .font(.title)
                           .frame(maxWidth: .infinity, alignment: .top)
                           .padding(EdgeInsets(
                               top: 60,
                               leading: 0,
                               bottom: 60,
                               trailing: 0
                           ))
                           .background(Color("backgroundMain"))
                   }
                   
                       VStack {
                           HStack{
                               Text("天気 ")
                                   .padding()
                                   .font(.title)
                               Text("\(result)")
                                   .foregroundColor(.gray)
                                   .fontWeight(.bold)
                                   .padding()
                           }.frame(minWidth: 0.0, maxWidth: .infinity, alignment: .leading)
                               .padding(.leading, 50)
                           
                           HStack{
                               Text("気温 ")
                                   .padding()
                                   .font(.title)
                               Text("\(temp)")
                                   .foregroundColor(.gray)
                                   .fontWeight(.bold)
                                   .padding()
                           }.frame(minWidth: 0.0, maxWidth: .infinity, alignment: .leading)
                               .padding(.leading, 50)
                           
                           HStack{
                               Text("湿度 ")
                                   .padding()
                                   .font(.title)
                               Text("\(humidity)")
                                   .foregroundColor(.gray)
                                   .fontWeight(.bold)
                                   .padding()
                           }.frame(minWidth: 0.0, maxWidth: .infinity, alignment: .leading)
                               .padding(.leading, 50)
                       }

                       .background(.white)
                       .cornerRadius(15)
                       .padding()

                   // ナビゲーションボタン
                   .toolbar {
                       ToolbarItem(placement: .navigationBarTrailing) {
                           NavigationLink(destination: SettingCityView()) {
                               Image("settingArea")
                               Text("エリア設定").foregroundColor(Color.customeColor)
                           }
                       }
                   } // .toolbarここまで
                       
                   Text("\(Date.now.formatted(date: .long, time: .standard))")
                   
                   //  天気取得用
                   Button(action:{
                       var invokeURL = ""

                           invokeURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityValue),jp&appid=\(self.KeyCode)&lang=ja&units=metric"

                       //  天気情報を取得(API)
                       self.obj.getWeather(invoke_url: invokeURL, action: self.GetData)
                   }) {
                       Image("reload")
                           .padding()
                   }
                   Text("天気情報を取得する")
                       .font(.caption)
                   
               }.frame(alignment: .center)
               
               Spacer()

           }
       } // navigationviewここまで
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
       ContentView()
           .padding(15)
   }
}
