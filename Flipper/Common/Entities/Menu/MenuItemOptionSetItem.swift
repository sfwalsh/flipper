//
//  MenuItemOptionSetItem.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct MenuItemOptionSetItem: Decodable {
    let id: Int
    let name: String
    let price: Double?
    let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "MenuItemOptionSetItemId"
        case name = "Name"
        case price = "Price"
        case imageUrl = "ImageUrl"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.price = try values.decodeIfPresent(Double.self, forKey: .price)
        self.imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
    }
}

/*
 API Sample:
 
    {
      "MenuItemOptionSetItemId": 13502402,
      "Name": "Cheese",
      "Price": 0.50,
      "TaxRateId": null,
      "TaxRate": null,
      "TaxValue": 0.0,
      "IsAvailable": true,
      "DisplayOrder": 0,
      "IsDeleted": false,
      "Tags": [
        
      ],
      "NextMenuItemOptionSetId": null,
      "PublicId": "7a9f0344-ce7e-491e-824c-4ba319114b2f",
      "ImageName": null,
      "ImageUrl": null,
      "CellAspectRatio": 0.0,
      "CellLayoutType": 0,
      "OptionSetItemMetadata": [
        
      ]
    }
*/
 
