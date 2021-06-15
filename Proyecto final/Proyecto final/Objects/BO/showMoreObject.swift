//
//  showMoreObject.swift
//  Proyecto final
//
//  Created by Rafael Jaime Moreno on 10/6/21.
//

import UIKit

enum showMore {
    case image(String), title(String), subtitle(String), text(String), date(String, String?), event(EventBO), post(String, String), answer(String, String), noAnswers, contacts(String, String?), button, location(String, String)
}
