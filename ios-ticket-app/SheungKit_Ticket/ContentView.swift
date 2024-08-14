//
//  ContentView.swift
//  SheungKit_Ticket
//
//  Created by Simon Chan on 2024-06-03.
//

import SwiftUI

struct ContentView: View {
    var eventType = ["Basketball", "Baseball", "Soccer", "Concert", "Theater"]
    var eventPrice = ["Basketball": 120.0, "Baseball": 80, "Soccer": 70, "Concert": 220.0, "Theater": 60.0]
    var venueType = ["Scotia Bank Arena", "Roger's Center", "Enercare Centre"]
    var seatingArea = ["VIP", "Regular", "Senior"]
    
    @State private var event = "Basketball"
    @State private var venue = "Scotia Bank Arena"
    @State private var seating = "VIP"
    @State private var quantity = 1
    @State private var userName = ""
    @State private var phoneNumber = ""
    @State private var couponCode = ""
    @State private var showAlert: Bool = false
    @State private var message: String = ""
    @State private var messageTitle: String = ""
    
    var body: some View {
        NavigationStack{
            VStack {
                Form {
                    Section(header: Text("Event Details")){
                        Picker("Select a Event", selection: self.$event){
                            ForEach(self.eventType, id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        Picker("Select a Venue", selection: self.$venue){
                            ForEach(self.venueType, id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        Picker("Select a Seating Area", selection: self.$seating){
                            ForEach(self.seatingArea, id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        Stepper(value: $quantity, in: 1...10) {
                            Text("Quantity of tickets: \(quantity)")
                        }
                    }//Section-Event
                    .font(.headline)
                    Section(header: Text("User Info")){
                        TextField("Enter your name", text: self.$userName)
                            .keyboardType(.default)
                        TextField("Enter your phone number", text: self.$phoneNumber)
                            .keyboardType(.numberPad)
                    }//Section-User
                    .font(.headline)
                    Section(header: Text("Coupon Code")){
                        TextField("Enter coupon code", text: self.$couponCode)
                            .keyboardType(.namePhonePad)
                    }//Section-Coupon
                    .font(.headline)
                }//Form
                Button(action: {
                    placeOrder()
                }){
                    Text("PLACE ORDER")
                }//Button
                .padding()
                .foregroundColor(.white)
                .bold()
                .background(.blue)
                .cornerRadius(100)
                
                .alert(isPresented: self.$showAlert){
                    Alert(title: Text(self.messageTitle),
                          message: Text(self.message),
                          dismissButton: .default(Text("Dismiss")){
                        self.resetForm()
                    })
                }//Alert
            }//VStack
            .padding()
            .padding(.bottom, 100)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Button{
                            eventSpecial()
                        }label: {
                            Text("EVENT SPECIAL")
                        }
                        Button{
                            resetForm()
                        }label: {
                            Text("RESET")
                        }
                    }label: {
                        Image(systemName: "gear")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle(Text("Sheung Kit Chan"))
            .navigationBarTitleDisplayMode(.inline)
        }//NavigationStack
    }//body
    
    private func placeOrder() {
        guard !self.userName.isEmpty, !self.phoneNumber.isEmpty else {
            message = "Name and phone number are mandatory fields. Order cannot be placed if these values are not provided."
            messageTitle = "ERROR"
            showAlert = true
            return
        }
        let isValidCoupon = couponCode.hasPrefix("VENUE")
        guard couponCode.isEmpty || isValidCoupon else {
            couponCode = ""
            message = "Invalid coupon code!"
            messageTitle = "ERROR"
            showAlert = true
            return
        }
        
        var basePrice = eventPrice[event]! * Double(quantity)
        if seating == "VIP" {
            basePrice = basePrice * 1.8
        } else if seating == "Senior" {
            basePrice = basePrice * 0.5
        }
        let discount = isValidCoupon ? 0.2 : 0.0
        let totalPrice = basePrice * (1 - discount) * 1.13
        
        let order = TicketInfo(event: event, venue: venue, seating: seating, quantity: quantity, userName: userName, phoneNumber: phoneNumber, couponCode: couponCode, totalPrice: totalPrice)
        
        message = """
        Event : \(order.event)
        Venue : \(order.venue)
        Seating Area : \(order.seating)
        Quantity : \(order.quantity)
        Total Price : $\(String(format: "%.2f", order.totalPrice))
        """
        messageTitle = "Order Details"
        showAlert = true
    }//place order func
    
    private func resetForm(){
        event = "Basketball"
        venue = "Scotia Bank Arena"
        seating = "VIP"
        quantity = 1
        userName = ""
        phoneNumber = ""
        couponCode = ""
    }//reset func
    
    private func eventSpecial(){
        event = "Baseball"
        venue = "Roger's Center"
        quantity = 2
        couponCode = "VENUE1"
    }//event special func
    
}//ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
