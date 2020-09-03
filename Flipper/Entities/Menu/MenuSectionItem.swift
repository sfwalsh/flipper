//
//  MenuSectionItem.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct MenuSectionItem: Decodable {
    
    let id: Int
    let name: String
    let description: String?
    let price: Double?
    let imageUrl: String?
    let optionSets: [MenuItemOptionSet]
    
    private enum CodingKeys: String, CodingKey {
        case id = "MenuItemId"
        case name = "Name"
        case description = "Description"
        case price = "Price"
        case imageUrl = "ImageUrl"
        case optionSets = "MenuItemOptionSets"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.description = try values.decodeIfPresent(String.self, forKey: .description)
        self.price = try values.decodeIfPresent(Double.self, forKey: .price)
        self.imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        self.optionSets = try values.decodeIfPresent([MenuItemOptionSet].self, forKey: .optionSets) ?? []
    }
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
