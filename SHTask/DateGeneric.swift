//
//  DateGeneric.swift
//  SHTask
//
//  Created by Emad Habib on 28/10/2022.
//

import Foundation

enum DateFormatApp {
    
    case birthdayApp
    case birthdayServer
    case storeDate
    case uploadPic
    case facebookServer

    case DayHour24
    case DayHour12

    case weightUpdateTimeServer
    
    case snapFormat
    case weekDayName

    case weatherFull
    case yearMonthDay
    
    var text:String{
        
        switch self {
        case.yearMonthDay:
            return "yyyy-MM-dd"
        case.weatherFull:
            return "EEEE, d MMM yyyy"
        case .birthdayApp ,.facebookServer:
            return "MM/dd/yyyy"
        case .birthdayServer, .weightUpdateTimeServer, .storeDate:
//            return "MM/dd/yyyy hh:mm:ss a"
            return "yyyy-MM-dd HH:mm" //2022-10-28 22:15
            
        case .uploadPic:
            return "yyyyMMdd_HHmmss"
        case .snapFormat:
            return "MMMM dd, yyyy"
        case .DayHour24:
            return "HH:mm"
        case .DayHour12:
            return "hh:mm a"
        case .weekDayName:
            return "EEEE"
        }
    }
}
struct DateApp {
    
    static func date(fromString stringDate:String ,withFormat format:DateFormatApp) -> Date? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format.text
        formatter.locale = Locale(identifier: "en_US_POSIX") // For time format.
        formatter.timeZone = TimeZone(abbreviation:"UTC") // for calculate time.
        
        if let date = formatter.date(from: stringDate){
            return date
        }
        return nil
    }
    
    static func dateLocal(fromString stringDate:String ,withFormat format:DateFormatApp) -> Date? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format.text
        formatter.locale = Locale(identifier: "en_US_POSIX") // For time format.
        formatter.timeZone = TimeZone.current // for calculate time.
        
        if let date = formatter.date(from: stringDate){
            return date
        }
        return nil
    }
    
    static func string(fromDate date:Date, withFormat format:DateFormatApp) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.text
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation:"UTC")
        return formatter.string(from: date)
    }
    
    static func stringWithLocalTime(fromDate date:Date, withFormat format:DateFormatApp) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.text
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
    
}
