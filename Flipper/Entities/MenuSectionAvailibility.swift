//
//  MenuSectionAvailibility.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

/*
 
 NOTE: The `MenuSectionAvailibility` Object is a flattened version of the API response, taking only into account the `AvailableTimes` path
 */

struct MenuSectionAvailibility {
    let id: Int
    let dayOfWeek: Int
    let startTime: String
    let period: String
    let startTimeEarly: String?
    let periodEarly: String?
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
