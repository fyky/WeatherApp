//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by fyky on 2022/02/02.
//

import Foundation

// Json

// MARK: - Welcome
struct Temperatures: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int

}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

//  結果を戻す関数型定義
typealias RecvFunc = ((_ item:Temperatures) -> Void)?

// 天気情報を取得するクラス
class WeatherModel {
   //  関数ポインタ
   var _action : ((_ item:Temperatures) -> Void)?
   
   //  結果受け取り用関数ポインタの設定
   func SetAction(action: ((_ item:Temperatures) -> Void)?) {
       self._action = action
   }
   //  天気情報を取得(APIコール)
   func getWather(invoke_url: String, action: RecvFunc) -> Void{
       //  関数ポインタをセット
       self.SetAction(action: action)
       
       guard let url = URL(string: invoke_url) else {
           print("URLが取得できませんでした")
           return
       }
       
       let request = URLRequest(url: url)
       //  非同期通信を実行
       URLSession.shared.dataTask(with: request) {
           data, response, error in
           //  受信が完了したら
           if let data = data {
               //  取得データのJSONをデコード
               if let decodedResponse = try? JSONDecoder().decode(Temperatures.self, from: data) {
                   DispatchQueue.main.async {
                       //  セットした関数を呼び出して結果を返す
                       self._action!(decodedResponse)
                   }
               }
           }
       }
       //  タスク実行
       .resume()
   }
}
