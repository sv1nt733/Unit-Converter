//
//  ContentView.swift
//  Unit Converter
//
//  Created by Dillon Waugh on 17/10/2022.
//

import SwiftUI


struct ContentView: View {

    @State private var preConversionValue = 0
    @State private var postConversionValue = 0
    @State private var inputValue = ""
    @FocusState private var isTextFieldFocused: Bool
    
    //Unit conversion array using UnitDuration class from NSMeasurement
    let conversionUnits = [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds, UnitDuration.milliseconds]
    
    //Calculated Properties for Unit Conversion
    var conversionOutput: Measurement<UnitDuration> {
        let inputValues = Measurement(value: Double(inputValue) ?? 0, unit: conversionUnits[preConversionValue])
        let outputValues = inputValues.converted(to: conversionUnits[postConversionValue])
        return outputValues
    }
    
    
    //ensures values conform to unit type format
    var formatter: MeasurementFormatter {
        let unitFormat = MeasurementFormatter()
        unitFormat.unitStyle = .long
        unitFormat.unitOptions = .providedUnit
        return unitFormat
    }
    
    var body: some View {
        ZStack{
            NavigationView{
                ZStack{
                    
                    Form{
                        Section(header: Text("Enter Value")){
                            TextField("Enter an Amount", text: $inputValue)
                                .keyboardType(.decimalPad)
                                .focused($isTextFieldFocused)
                        }
                        
                        Section(header: Text("From")){
                            Picker("From", selection: $preConversionValue) {
                                ForEach(0..<conversionUnits.count, id: \.self){
                                    let formattedConversion = formatter.string(from: conversionUnits[$0])
                                    Text("\(formattedConversion)")
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(idealHeight: 100)
                            
                        }
                        
                        
                        
                        Section(header: Text("To")){
                            Picker("To", selection: $postConversionValue) {
                                ForEach(0..<conversionUnits.count, id: \.self){
                                    let formattedConversion = formatter.string(from: conversionUnits[$0])
                                    Text("\(formattedConversion)")
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(idealHeight: 100)
                        }
                        
                        Section(header: Text("Output Value")){
                            Text(formatter.string(from: conversionOutput))
                            
                        }
                        
                        .navigationTitle("Time Converter")
                        .navigationBarTitleDisplayMode(.inline)
                        
                    }
                }
                   
            }
            
            
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
