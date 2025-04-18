//
//  ContentView.swift
//  KitchenBuddy
//
//  Created by Eric Parker on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    @State private var amount: String = "1"
    @State private var fromUnit: String = "ml"
    @State private var toUnit: String = "liter"
    @State private var result: String = ""

    let units = ["ml", "liter", "cup", "fl_oz", "tbsp", "tsp", "gram", "kg", "oz", "lb"]

    func convert() {
        guard let amountValue = Double(amount) else {
            result = "Invalid input"
            return
        }

        var ml: Double?
        var grams: Double?

        switch fromUnit {
            case "ml": ml = amountValue
            case "liter": ml = amountValue * 1000
            case "cup": ml = amountValue * 240
            case "fl_oz": ml = amountValue * 29.5735
            case "tbsp": ml = amountValue * 14.7868
            case "tsp": ml = amountValue * 4.92892
            case "gram": grams = amountValue
            case "kg": grams = amountValue * 1000
            case "oz": grams = amountValue * 28.3495
            case "lb": grams = amountValue * 453.592
            default: break
        }

        if let mlValue = ml {
            switch toUnit {
                case "ml": result = "\(amountValue) \(fromUnit) is \(mlValue) ml"
                case "liter": result = "\(amountValue) \(fromUnit) is \((mlValue / 1000).formatted()) L"
                case "cup": result = "\(amountValue) \(fromUnit) is \((mlValue / 240).formatted()) cups"
                case "fl_oz": result = "\(amountValue) \(fromUnit) is \((mlValue / 29.5735).formatted()) fl oz"
                case "tbsp": result = "\(amountValue) \(fromUnit) is \((mlValue / 14.7868).formatted()) tbsp"
                case "tsp": result = "\(amountValue) \(fromUnit) is \((mlValue / 4.92892).formatted()) tsp"
                default: result = "Cannot convert volume to weight"
            }
        } else if let gramsValue = grams {
            switch toUnit {
                case "gram": result = "\(amountValue) \(fromUnit) is \(gramsValue) g"
                case "kg": result = "\(amountValue) \(fromUnit) is \((gramsValue / 1000).formatted()) kg"
                case "oz": result = "\(amountValue) \(fromUnit) is \((gramsValue / 28.3495).formatted()) oz"
                case "lb": result = "\(amountValue) \(fromUnit) is \((gramsValue / 453.592).formatted()) lb"
                default: result = "Cannot convert weight to volume"
            }
        } else {
            result = "Conversion error"
        }
    }

    var body: some View {
        VStack {
            
            HStack {
                Text("Amount")
                TextField("Amount", value: $amount, formatter: NumberFormatter())
                    //.padding()
            }
            .padding()

            Picker("From Unit", selection: $fromUnit) {
                ForEach(units, id: \.self) { unit in
                    Text(unit)
                }
            }
            .padding()

            Picker("To Unit", selection: $toUnit) {
                ForEach(units, id: \.self) { unit in
                    Text(unit)
                }
            }
            .padding()

            Button("Convert") {
                convert()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(8)

            Text(result)
                .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
