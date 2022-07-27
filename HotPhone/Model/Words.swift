//
//  Words.swift
//  HotPhone
//
//  Created by Ashley Smith on 5/11/22.
//

import Foundation

public class Words {

    public var people = UserDefaults.standard.stringArray(forKey: K.peopleDefault)
    public var objects = UserDefaults.standard.stringArray(forKey: K.objectsDefault)
    public var world = UserDefaults.standard.stringArray(forKey: K.worldDefault)
    public var food = UserDefaults.standard.stringArray(forKey: K.foodDefault)
    public var variety = UserDefaults.standard.stringArray(forKey: K.varietyDefault)
    public var popCulture = UserDefaults.standard.stringArray(forKey: K.popCultureDefault)

    public func saveWords() {
        UserDefaults.standard.set(people, forKey: K.peopleDefault)
        UserDefaults.standard.set(world, forKey: K.worldDefault)
        UserDefaults.standard.set(food, forKey: K.foodDefault)
        UserDefaults.standard.set(objects, forKey: K.objectsDefault)
        UserDefaults.standard.set(variety, forKey: K.varietyDefault)
        UserDefaults.standard.set(popCulture, forKey: K.popCultureDefault)
    }
}
