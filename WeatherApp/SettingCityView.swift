//
//  SettingCityView.swift
//  WeatherApp
//
//  Created by fyky on 2022/02/03.
//

import SwiftUI

struct SettingCityView: View {
    @AppStorage("city_value") var cityValue = "Ichinomiya"
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(
                    action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward")
                    }
                ).tint(.white)
            }
        }
        
        ZStack {
            Color("area")
                .ignoresSafeArea()
            
            VStack {
                Text("エリアを設定する")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding(EdgeInsets(
                        top: 100,
                        leading: 0,
                        bottom: 30,
                        trailing: 0
                    ))
                    .background(Color("backgroundMain"))
                     .foregroundColor(Color.black.opacity(0.7))
                    .ignoresSafeArea()

                
                if (cityValue == "Nagoya"){
                    Text("愛知県名古屋市")
                        .font(.title)
                } else if (cityValue == "Ichinomiya") {
                    Text("愛知県一宮市")
                        .font(.title)
                } else if (cityValue == "Tokyo") {
                    Text("東京都")
                        .font(.title)
                } else {
                    Text("大阪府")
                        .font(.title)
                }

//                HStack {
//                    Image("sun")
//                    Image("umbrella")
//                    Image("sun")
//                    Image("umbrella")
//                    Image("sun")
//                    Image("umbrella")
//                    Image("sun")
//                    Image("umbrella")
//                    Image("sun")
//                }
                
                Spacer()
                
                Picker(selection: $cityValue) {
                    Text("愛知県名古屋市")
                        .tag("Nagoya")
                    Text("愛知県一宮市")
                        .tag("Ichinomiya")
                    Text("大阪府")
                        .tag("Osaka")
                    Text("東京都")
                        .tag("Tokyo")
                } label: {
                    Text("選択")
                }
                .pickerStyle(.wheel)
                
                Spacer()
            }
        }
    }
}

struct SettingCityView_Previews: PreviewProvider {
    static var previews: some View {
        SettingCityView()
    }
}
