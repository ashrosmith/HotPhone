//
//  Words.swift
//  HotPhone
//
//  Created by Ashley Smith on 5/11/22.
//

import Foundation

public class Words {

    var people = UserDefaults.standard.stringArray(forKey: K.peopleDefault)
    var objects = UserDefaults.standard.stringArray(forKey: K.objectsDefault)
    var world = UserDefaults.standard.stringArray(forKey: K.worldDefault)
    var food = UserDefaults.standard.stringArray(forKey: K.foodDefault)
    var variety = UserDefaults.standard.stringArray(forKey: K.varietyDefault)
    var popCulture = UserDefaults.standard.stringArray(forKey: K.popCultureDefault)

    func saveWords() {
        UserDefaults.standard.set(people, forKey: K.peopleDefault)
        UserDefaults.standard.set(world, forKey: K.worldDefault)
        UserDefaults.standard.set(food, forKey: K.foodDefault)
        UserDefaults.standard.set(objects, forKey: K.objectsDefault)
        UserDefaults.standard.set(variety, forKey: K.varietyDefault)
        UserDefaults.standard.set(popCulture, forKey: K.popCultureDefault)
    }
}
