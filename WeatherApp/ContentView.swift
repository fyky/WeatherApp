//
//  ContentView.swift
//  WeatherApp
//
//  Created by fyky on 2022/02/02.
//

import SwiftUI

struct ContentView: View {

    let date = Date.now
    
    // 子ビューから値を渡す
    @AppStorage("city_value") var cityValue = "Tokyo"
    
   //  天気情報
   @State var result = ""
   //  気温
   @State var temp = ""
   //  湿度
   @State var humidity = ""
    
//   @State var weathericon = ""
    
    
//   //  天気情報を取得する場所
//   let cityValue = "Tokyo"
//
//
    
   //  キー情報
   let KeyCode = "946bc91fb84e19988d8b2207d6a2e17d"
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
//               Image("bg")
               
               VStack {
                   HStack {
                       Image("sun")
                       Image("umbrella")
                       Image("sun")
                       Image("umbrella")
                       Image("sun")
                       Image("umbrella")
                       Image("sun")
                   }
                   
                   if (cityValue == "Nagoya"){
                       Text("現在の愛知県名古屋市")
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
                   
//                   Text("現在の\(cityValue)の天気")
//                       .font(.title)
//                       .frame(maxWidth: .infinity, alignment: .top)
//                       .padding(EdgeInsets(
//                           top: 60,
//                           leading: 0,
//                           bottom: 60,
//                           trailing: 0
//                       ))
//                       .background(Color("backgroundMain"))
//
//

                       VStack {

                           
                           HStack{
                               Text("天気 ")
                                   .padding()
                                   .font(.title)
                               Text("\(result)")
                               .padding()
                           }.frame(minWidth: 0.0, maxWidth: .infinity, alignment: .leading)
                               .padding(.leading, 50)
                           
                           HStack{
                               Text("気温 ")
                                   .padding()
                                   .font(.title)
                               Text("\(temp)")
                               .padding()
                           }.frame(minWidth: 0.0, maxWidth: .infinity, alignment: .leading)
                               .padding(.leading, 50)
                           
                           HStack{
                               Text("湿度 ")
                                   .padding()
                                   .font(.title)
                               Text("\(humidity)")
                               .padding()
                           }.frame(minWidth: 0.0, maxWidth: .infinity, alignment: .leading)
                               .padding(.leading, 50)
                       }
    //                   .frame(minWidth: 0.0, maxWidth: .infinity)
    //                   .frame(height: 150)

                       .background(.white)
//                       .border(Color.black, width: 3)
                       .cornerRadius(15)
                       .padding()

    //                   .frame(maxWidth: .infinity,
    //                          alignment:.leading
    //                   )

                       // ナビゲーションボタン
                       .toolbar {
                           ToolbarItem(placement: .navigationBarTrailing) {
                               NavigationLink(destination: SettingCityView()) {
//                                   Image("settingArea")
                                   Text("エリア設定")
//                                       .foregroundColor(.gray)
                               }
                           }
                       } // .toolbarここまで
                       

                   Text("\(Date.now.formatted(date: .long, time: .standard))")
                   
                   //  天気取得用
                   Button(action:{
                       var invokeURL = ""

                           invokeURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityValue),jp&appid=\(self.KeyCode)&lang=ja&units=metric"

                       //  天気情報を取得(APIコール)
                       self.obj.getWeather(invoke_url: invokeURL, action: self.GetData)
                   })
                   {
                       Image("reload")
                           .padding()
                   }
                   
                   
                   
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
