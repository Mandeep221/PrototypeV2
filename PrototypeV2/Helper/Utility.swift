//
//  Utility.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-17.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

class Utility{
    
    static var ref: DatabaseReference?

    static func updateProgressTimestamp(_ moduleType: String, _ timeElapsed: Int){
        
        //let currentDateTimeStamp = Date().toMillis()
        
        var date1: Int64  = 0
        var date2: Int64 = 0
        var date3: Int64 = 0
        
        var duration1: Int = 0
        var duration2: Int = 0
        var duration3: Int = 0
        
        ref = Database.database().reference()
        
        if let user = Auth.auth().currentUser{
            ref?.child("users").child((user.uid)).child("modules").child(moduleType).child("progress").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let value = snapshot.value as? NSDictionary{
                    
                    print("Path exists")
                    // If path users/modules/<moduleType>/progress already exists
                    
                    if let timeStamp1 = value["timestamp1"] as? NSDictionary{
                        date1 = (timeStamp1["date"] as? Int64)!
                        duration1 = (timeStamp1["duration"] as? Int)!
                        print("date1 and duration1 value is :\(date1)  \(duration1)")
                    }
                    
                    if let timeStamp2 = value["timestamp2"] as? NSDictionary{
                        
                        date2 = (timeStamp2["date"] as? Int64)!
                        duration2 = (timeStamp2["duration"] as? Int)!
                        
                        print("date2 and duration2 value is :\(date2)  \(duration2)")
                    }
                    
                    if let timeStamp3 = value["timestamp3"] as? NSDictionary{
                        
                        date3 = (timeStamp3["date"] as? Int64)!
                        duration3 = (timeStamp3["duration"] as? Int)!
                        print("date3 and duration3 value is :\(date3)  \(duration3)")
                    }
                    
                    
                    // write the algo here now by fetching individual dates
                    
                    if (checkIfDateIsSameAsToday(dateTimeStamp: date1)){
                        duration1 = duration1 + timeElapsed
                    }else if(date1 == 0){
                        //date1 is 0,  assign today's dateTimeStamp
                        date1 = Date().toMillis()
                        duration1 = timeElapsed
                    }else{
                        // date1 is less than today's date
                        // So check date2
                        if(checkIfDateIsSameAsToday(dateTimeStamp: date2)){
                            duration2 = duration2 + timeElapsed
                        }else if(date2 == 0)
                        {
                            //date2 is 0,  assign today's dateTimeStamp
                            date2 = Date().toMillis()
                            duration2 = timeElapsed
                        }else{
                            // date2 is less than today's date
                            // So check date3
                            if(checkIfDateIsSameAsToday(dateTimeStamp: date3)){
                                duration3 = duration3 + timeElapsed
                            }else if(date3 == 0)
                            {
                                //date3 is 0,  assign today's dateTimeStamp
                                date3 = Date().toMillis()
                                duration3 = timeElapsed
                            }else{
                                // date3 is less than today's date
                                // that implies all dates are less than Today's date
                                // Its time to shift all the dates
                                date1 = date2
                                duration1 = duration2
                                date2 = date3
                                duration2 =  duration3
                                date3 = Date().toMillis()
                                duration3 = timeElapsed
                            }
                        }
                    }
                    
                    // Update Firebase
                    self.ref?.child("users/\(user.uid)/modules/\(moduleType)/progress/timestamp1/date").setValue(date1)
                    self.ref?.child("users/\(user.uid)/modules/\(moduleType)/progress/timestamp1/duration").setValue(duration1)
                    self.ref?.child("users/\(user.uid)/modules/\(moduleType)/progress/timestamp2/date").setValue(date2)
                    self.ref?.child("users/\(user.uid)/modules/\(moduleType)/progress/timestamp2/duration").setValue(duration2)
                    self.ref?.child("users/\(user.uid)/modules/\(moduleType)/progress/timestamp3/date").setValue(date3)
                    self.ref?.child("users/\(user.uid)/modules/\(moduleType)/progress/timestamp3/duration").setValue(duration3)
                    
                }else{
                    // Path users/modules/<moduleType>/progress does NOT exist, So create it and push the data
                    
                    self.ref?.child("users/\(user.uid)/modules/\(moduleType)/progress/timestamp1/date").setValue(Date().toMillis())
                    self.ref?.child("users/\(user.uid)/modules/\(moduleType)/progress/timestamp1/duration").setValue(timeElapsed)
                }
                
            })
        }
    }
    
    static func submitChallenge(moduleType: String, num1: Int, num2: Int = 0){
         ref = Database.database().reference()
        if let user = Auth.auth().currentUser{
            self.ref?.child("users/\(user.uid)/modules/\(moduleType)/challenge/num1").setValue(num1)
            self.ref?.child("users/\(user.uid)/modules/\(moduleType)/challenge/num2").setValue(num2)
        }
        
    }
    
    static func checkIfDateIsSameAsToday(dateTimeStamp: Int64) -> Bool {
        
        // convert millis into a Date object
        let date = Date(timeIntervalSince1970: (TimeInterval(dateTimeStamp / 1000)))
        //var futureDate = Date(timeIntervalSince1970: (TimeInterval(1637470576795 / 1000)))
        // Format the Date object and get only the date out of it without time component
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd,yyyy"
        let givenDate = formatter.string(from: date)
        let currentDate = formatter.string(from: Date())
        
        print(givenDate)
        print(currentDate)
        
        // compare
        if(givenDate == currentDate){
            return true
        }else{
            return false
        }
    }
    
    static func secondsToHoursMinutesSeconds (seconds : Int) -> (String) {
        let hr = seconds / 3600
        let min = (seconds % 3600) / 60
        let sec = (seconds % 3600) % 60
        
        var time = ""
        if(hr != 0){
            time = hr > 1 ? time + "\(hr) hrs":"\(hr) hr"
        }
        
        if(min != 0){
            time = min > 1 ? time + "\(min) mins":"\(min) min"
        }
        
        if(sec != 0){
            time = sec > 1 ? time + "\(sec) secs":"\(min) min"
        }
        
        return time
        
    }
    
    static func getReadableDate(timeInMillis: Int64) -> String{
        // convert millis into a Date object
        let date = Date(timeIntervalSince1970: (TimeInterval(timeInMillis / 1000)))
        //var futureDate = Date(timeIntervalSince1970: (TimeInterval(1637470576795 / 1000)))
        // Format the Date object and get only the date out of it without time component
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        let requiredDate = formatter.string(from: date)
        
        return requiredDate
    }
}
