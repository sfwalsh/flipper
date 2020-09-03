//
//  MenuItemOptionSet.swift
//  Flipper
//
//  Created by Stephen Walsh on 03/09/2020.
//  Copyright © 2020 Stephen Walsh. All rights reserved.
//

import Foundation

struct MenuItemOptionSet: Decodable {
    let id: Int
    /*
         When IsMasterOptionSet is set to true on a MenuItemOptionSet, the price of the
         menu item is calculated based on the MenuItemOptionSetItems in the
         MenuItemOptionSet, and the price set on the MenuSectionItem is ignored.
     */
    let isMasterOptionSet: Bool
    let items: [MenuItemOptionSetItem]
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "MenuItemOptionSetId"
        case isMasterOptionSet = "IsMasterOptionSet"
        case items = "MenuItemOptionSetItems"
        case name = "Name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.isMasterOptionSet = try values.decode(Bool.self, forKey: .isMasterOptionSet)
        self.items = try values.decodeIfPresent([MenuItemOptionSetItem].self, forKey: .items) ?? []
    }
}

/*
 
 API Sample:
 
    {
      "Name": null,
      "MenuItemOptionSetId": 1494263,
      "IsMasterOptionSet": false,
      "DisplayOrder": 0,
      "MinSelectCount": 0,
      "MaxSelectCount": 4,
      "IsDeleted": false,
      "PublicId": "796c3858-3580-4c66-9bf3-e2f877d6605b",
      "MenuItemOptionSetItems": [],
      "ImageName": null,
      "ImageUrl": null,
      "CellAspectRatio": 0.0,
      "CellLayoutType": 0,
      "MinPrice": 0.00,
      "MenuItemId": 1299636,
      "MenuItemOptionSetMetadata": []
    }
*/
