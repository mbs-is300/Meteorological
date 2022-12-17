//
//  DayWeather.swift
//  NCM
//
//  Created by Meshal Alsallami on 15/12/2022.
//

import SwiftUI

struct DayWeather: View {
    
    var user_cities = ["Jeddah", "Makkah"]
    
    var body: some View {
        
        ZStack {
            // Mark: Background Color
            LinearGradient(colors: [.blue, .cyan, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            // Mark: - Main Stack
            
            VStack{
                
                ForEach(user_cities, id: \.self) { city in
                    
                    HStack {
                        Text(city)
                            .padding(10)
                            .font(.system(size: 32, weight: .black, design: .default))
                        
                        Image(systemName: "cloud.sun.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .aspectRatio(contentMode: .fit)
                        
                        
                        Text("29º")
                            .padding(10)
                            .font(.system(size: 32, weight: .black, design: .default))
                    }
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct DayWeather_Previews: PreviewProvider {
    static var previews: some View {
        DayWeather()
    }
}
