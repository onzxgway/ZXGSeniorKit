//
//  TypeCastingController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/9/10.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
 类型转换
    1.为类型转换定义类层次
    2.检查类型
    3.向下转型
    4.Any和AnyObject的类型转换
 */

// MARK: - 1.为类型转换定义类层次
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

class TypeCastingController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test()
        test_one()
    }
    
    func test() -> Void {
        let library = [
            Movie.init(name: "Casablanca", director: "MC"),
            Song.init(name: "Blue Suede Shoes", artist: "EP"),
            Movie.init(name: "DoyYellow", director: "DJ"),
            Song.init(name: "WaHaHa", artist: "OK"),
            Song.init(name: "Bjack", artist: "RV")
        ]
        
        // MARK: - 2.检查类型
        /*
         类型检查操作符（is） = isKindOf 作用：检测是否为特定类型或其子类型的实例。
         */
        print(library is Array<MediaItem>)
        print(library is Array<Movie>)
        print(library is Array<Song>)
        
//        let m = Movie.init(name: "adfdaf", director: "MCdd")
        
        var movieCount = 0
        var songCount = 0
        
        for item in library {
            if item is Movie {
                movieCount += 1
            }
            else if item is Song {
                songCount += 1
            }
        }
        
        print("Media library contains \(movieCount) movies and \(songCount) songs")
        
        
        // MARK: - 3.向下转型
        /*
         as? 和 as!
         转换没有真的改变实例或它的值。根本的实例保持不变。
         */
        for item in library {
            // “尝试将 item 转为 Movie 类型。若成功，设置一个新的临时常量 movie 来存储返回的可选 Movie 中的值”
            if let movie = item as? Movie {
                print("Movie: \(movie.name), dir. \(movie.director)")
            }
            else if let song = item as? Song {
                print("Song: \(song.name), by \(song.artist)")
            }
        }
    }
    
    // MARK: - 4.Any和AnyObject的类型转换
    /*
     Any 可以表示任何类型，包含函数类型。
     AnyObject 可以表示任何类类型的实例。
     Any类型可以表示所有类型的值，包括可选类型。Swift会在你用Any类型来表示可选值的时候，给你一个警告。如果你确实想使用Any类型来承载可选值，你可以使用as操作符显示转换为Any。
     */
    func test_one() -> Void {
        var things = [Any]()
        
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.1415926)
        things.append("hello")
        things.append((3.5, 6.2))
        things.append(Movie.init(name: "Jack", director: "BB"))
        
        let optionalNumber: Int? = 33
        things.append(optionalNumber as Any)
        
        for item in things {
            switch item {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as an Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let tempD as Double where tempD > 0:
                print("双精度浮点值\(tempD)")
            case is Double:
                print("双精度浮点值我无法打印，😢")
            case let someString as String:
                print("a string value of '\(someString)'")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let movie as Movie:
                print("a movie called \(movie.name), dir. \(movie.director)")
            default:
                print("something else")
            }
        }
        
        /*
        for item in things {
            switch item {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as an Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("some other double value that I don`t want to print")
            case let someString as String:
                print("a string value of '\(someString)'")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let movie as Movie:
                print("a movie called \(movie.name), dir. \(movie.director)")
            default:
                print("something else")
            }
        }
        */
    }

}
