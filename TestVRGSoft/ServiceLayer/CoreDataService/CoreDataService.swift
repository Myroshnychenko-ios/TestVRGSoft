//
//  CoreDataService.swift
//  TestVRGSoft
//
//  Created by Максим Мирошниченко on 07.10.2021.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataServiceProtocol {
    
    // MARK: - CoreData service protocol
    
    func save(film: Film, completion: @escaping (Result<Bool, Error>) -> Void)
    func delete(film: Film, completion: @escaping (Result<Bool, Error>) -> Void)
    func found(film: Film, completion: @escaping (Bool) -> Void)
    func fetch(completion: @escaping (Result<[CDFilm], Error>) -> Void)
    
}

class CoreDataService: CoreDataServiceProtocol {
    
    // MARK: - Protocol methods
    
    func save(film: Film, completion: @escaping (Result<Bool, Error>) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "CDFilm", in: context) else { return }
        let cDFilm = CDFilm(entity: entity, insertInto: context)
        cDFilm.displayTitle = film.displayTitle ?? "Error loading data"
        cDFilm.criticsPick = Int64(film.criticsPick ?? 404)
        cDFilm.byline = film.byline ?? "Error loading data"
        cDFilm.headline = film.headline ?? "Error loading data"
        cDFilm.summaryShort = film.summaryShort ?? "Error loading data"
        cDFilm.src = film.multimedia?.src
        do {
            try context.save()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    func delete(film: Film, completion: @escaping (Result<Bool, Error>) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CDFilm> = CDFilm.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "displayTitle = %@", film.displayTitle ?? "Error loading data")
        guard let films = try? context.fetch(fetchRequest) else { return }
        if films.count > 0 {
            for film in films {
                context.delete(film)
            }
        }
        do {
            try context.save()
            completion(.success(true))
        } catch {
            completion(.failure(error))
        }
    }
    
    func found(film: Film, completion: @escaping (Bool) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CDFilm> = CDFilm.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "displayTitle = %@", film.displayTitle ?? "Error loading data")
        guard let films = try? context.fetch(fetchRequest) else { return }
        if films.count > 0 {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func fetch(completion: @escaping (Result<[CDFilm], Error>) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CDFilm> = CDFilm.fetchRequest()
        do {
            let films = try context.fetch(fetchRequest)
            completion(.success(films))
        } catch {
            completion(.failure(error))
        }
    }
    
}
