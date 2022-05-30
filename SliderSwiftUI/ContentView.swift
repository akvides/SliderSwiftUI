//
//  ContentView.swift
//  SliderSwiftUI
//
//  Created by Василий Полторак on 30.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var redColorValue = Double.random(in: 0...255)
    @State private var greenColorValue = Double.random(in: 0...255)
    @State private var blueColorValue = Double.random(in: 0...255)
    
    @FocusState private var amountIsFocused: Bool
    @State private var presentAlert = false
    
    var body: some View {
        let redColor = Color(red: redColorValue/255, green: 0, blue: 0)
        let greenColor = Color(red: 0, green: greenColorValue/255, blue: 0)
        let blueColor = Color(red: 0, green: 0, blue: blueColorValue/255)
        
        ZStack{
            Color(.gray)
                .ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 280, height: 100)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .stroke(Color.white, lineWidth: 4))
                    .foregroundColor(Color(
                        red: redColorValue/255,
                        green: greenColorValue/255,
                        blue: blueColorValue/255))
                VStack{
                    ColorSlider(
                        colorValue: $redColorValue,
                        focused: _amountIsFocused,
                        color: redColor
                    )
                    ColorSlider(
                        colorValue: $greenColorValue,
                        focused: _amountIsFocused,
                        color: greenColor
                    )
                    ColorSlider(
                        colorValue: $blueColorValue,
                        focused: _amountIsFocused,
                        color: blueColor
                    )
                }
                .padding(.top)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button("Done", action: {checkColor()})
                            .alert("Слишком большое значение", isPresented: $presentAlert, actions: {}) {
                            Text("Введите значение от 0 до 255")
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
    func checkColor() {
        if redColorValue > 255 {
            redColorValue = 255
            presentAlert = true
        } else if greenColorValue > 255 {
            greenColorValue = 255
            presentAlert = true
        } else if blueColorValue > 255 {
            blueColorValue = 255
            presentAlert = true
        }
        
        amountIsFocused = false
    }
}

struct ColorSlider: View {
    
    @Binding var colorValue: Double
    @FocusState var focused: Bool
    let color: Color
    
    
    var body: some View {
        HStack {
            Text("\(lround(colorValue))")
                .frame(width: 35)
                .foregroundColor(color)
            Slider(value: $colorValue, in: 0...255, step: 1)
                .colorMultiply(color)
                .accentColor(color)
            TextField("<255", value: $colorValue, formatter: NumberFormatter())
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: 50)
                .focused($focused)
        }
        .frame(height: 35)
        .padding(.horizontal)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

