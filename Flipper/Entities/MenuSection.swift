//
//  MenuSection.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct MenuSection {
    let id: Int
    let name: String?
    let description: String?
    let imageUrl: String?
    let menuItems: [MenuSectionItem]
    let availability: [MenuSectionAvailibility]
}

/*
 
 API Sample:
 
    {
      "MenuSectionId": 194490,
      "Name": "Mains",
      "Description": null,
      "DisplayOrder": 0,
      "MenuItems": [],
      "PublicId": "0dfc594c-5fd5-4a94-b7c0-b7c9dbc2d71e",
      "IsDeleted": false,
      "IsAvailable": true,
      "IsHiddenFromUsers": false,
      "ImageName": "5csY9WytLuMFRJQt29QkV94iAps.jpg",
      "ImageUrl": "https://flipdish.imgix.net/5csY9WytLuMFRJQt29QkV94iAps.jpg",
      "CellAspectRatio": 4.0,
      "CellLayoutType": 0,
      "MenuSectionAvailability": {
        "AvailableTimes": [],
        "MenuSectionId": 194490,
        "AvailabilityMode": 1
      },
      "ConcessionStoreId": null,
      "MenuSectionMetadata": [
        
      ]
    },
*/
