//
//  TicketInfo.swift
//  SheungKit_Ticket
//
//  Created by Simon Chan on 2024-06-03.
//

import Foundation

struct TicketInfo {
    var event: String
    var venue: String
    var seating: String
    var quantity: Int
    var userName: String
    var phoneNumber: String
    var couponCode: String
    var totalPrice: Double
    
    init(event: String, venue: String, seating: String, quantity: Int, userName: String, phoneNumber: String, couponCode: String, totalPrice: Double) {
        self.event = event
        self.venue = venue
        self.seating = seating
        self.quantity = quantity
        self.userName = userName
        self.phoneNumber = phoneNumber
        self.couponCode = couponCode
        self.totalPrice = totalPrice
    }
}
