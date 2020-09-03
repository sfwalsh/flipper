//
//  MenuSectionItem.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct MenuSectionItem {
    let id: Int
    let name: String
    let description: String?
    let price: Double?
    let imageUrl: String?
    let optionSets: [MenuItemOptionSet]
}

/*
 
 API Sample:
 
     {
        "MenuItemId": 1299636,
        "Name": "Burger",
        "Description": "",
        "SpicinessRating": 0,
        "Price": 10.00,
        "DisplayOrder": 3,
        "IsDeleted": false,
        "Alcohol": false,
        "Tags": [
          
        ],
        "PublicId": "4315edcb-df23-415f-a763-438ac9b7e2fd",
        "IsAvailable": true,
        "MenuItemOptionSets": [],
        "TaxRate": null,
        "TaxRateId": null,
        "TaxValue": 0.0,
        "MenuSectionId": 194490,
        "ImageName": "FPY9VoQWKX8cItuATEYfxIu0WQ.jpg",
        "ImageUrl": "https://flipdish.imgix.net/FPY9VoQWKX8cItuATEYfxIu0WQ.jpg",
        "CellAspectRatio": 1.3,
        "CellLayoutType": 2,
        "ActualPrice": 10.00,
        "DisableVouchers": false,
        "ExcludeFromVoucherDiscounting": false,
        "DailySpecialHours": [
          
        ],
        "PriceCanIncrease": false,
        "MenuItemMetadata": [
          
        ]
      }
*/
