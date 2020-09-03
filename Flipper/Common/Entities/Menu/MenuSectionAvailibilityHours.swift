//
//  MenuSectionAvailibilityHours.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct MenuSectionAvailibilityHours: Decodable {
    
    let id: Int
    let dayOfWeek: Int
    let startTime: String
    let period: String
    let startTimeEarly: String?
    let periodEarly: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "BusinessHoursPeriodId"
        case dayOfWeek = "DayOfWeek"
        case startTime = "StartTime"
        case period = "Period"
        case startTimeEarly = "StartTimeEarly"
        case periodEarly = "PeriodEarly"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.dayOfWeek = try values.decode(Int.self, forKey: .dayOfWeek)
        self.startTime = try values.decode(String.self, forKey: .startTime)
        self.period = try values.decode(String.self, forKey: .period)
        self.startTimeEarly = try values.decodeIfPresent(String.self, forKey: .startTimeEarly)
        self.periodEarly = try values.decodeIfPresent(String.self, forKey: .periodEarly)
    }
    
}

/*
 
 API Sample:

    {
      "BusinessHoursPeriodId": 474055,
      "DayOfWeek": 1,
      "StartTime": "01:00:00",
      "Period": "23:00:00",
      "StartTimeEarly": "00:00:00",
      "PeriodEarly": "00:00:00"
    }

 */
