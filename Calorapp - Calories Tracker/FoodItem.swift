//
//  FoodItem.swift
//  Calorapp - Calories Tracker
//
//  Created by Bladimir Baez on 5/5/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation

class FoodItem: NSObject {
    private var name: String = ""
    private var calories: String = ""
    private var imageName: String = ""
    private var imageSize: String = ""
    private var imageType: String = ""
    private var imageLink: String = ""
    
    var title: String? {
        get {
            return name
        }
    }
    
    var subtitle: String? {
        get {
            return calories
        }
    }
    
    init(name: String, calories: String) {
        super.init()
        self.name = name
        self.calories = calories
    }
    
    func getFoodName() -> String {
        return name
    }
    
    func set(name: String) {
        self.name = name
    }
    
    func getCalories() -> String{
        return calories
    }
    
    func set(calories: String) {
        self.calories = calories
    }
    
    func getImageName() -> String{
        return imageName
    }
    
    func set(imageName: String) {
        self.imageName = imageName
    }
    
    func getImageSize() -> String{
        return imageSize
    }
    
    func set(imageSize: String) {
        self.imageSize = imageSize
    }
    
    func getImageType() -> String{
        return imageType
    }
    
    func set(imageType: String) {
        self.imageType = imageType
    }
    
    func getImageLink() -> String{
        return imageLink
    }
    
    func set(imageLink: String) {
        self.imageLink = imageLink
    }
    
    convenience override init() {
        self.init(name: "Unknown", calories: "Unknown")
    }
    
    init(name: String, calories: String, imageName: String, imageSize: String, imageType: String, imageLink: String) {
        super.init()
        set(name: name)
        set(calories: calories)
        set(imageName: imageName)
        set(imageSize: imageSize)
        set(imageType: imageType)
        set(imageLink: imageLink)
    }
}
