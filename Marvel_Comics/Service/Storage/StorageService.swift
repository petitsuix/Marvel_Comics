//
//  StorageService.swift
//  Marvel_Comics
//
//  Created by Richardier on 22/03/2022.
//

import CoreData

class StorageService {
    
    // MARK: - Properties
    
    private var viewContext: NSManagedObjectContext
    
    static private var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Marvel_Comics")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Methods
    
    init(persistentContainer: NSPersistentContainer = StorageService.persistentContainer) {
        self.viewContext = persistentContainer.viewContext
    }
    
    func loadComics() throws -> [ComicResult] {
        let fetchRequest: NSFetchRequest<ComicsEntity> = ComicsEntity.fetchRequest() // Retrieves a group of managed objects held in the persistent store
        let comicsEntities: [ComicsEntity]
        
        do { comicsEntities = try viewContext.fetch(fetchRequest) }
        catch { throw error }
        
        let comics = comicsEntities.map { (comicsEntity) -> ComicResult in
            return ComicResult(from: comicsEntity)
        }
        return comics
    }
    
    func saveComic(_ comic: ComicResult) throws {
        let comicEntity = ComicsEntity(context: viewContext)
        comicEntity.comicName = comic.title
        comicEntity.comicDescription = comic.description
        comicEntity.comicCover = try? JSONEncoder().encode(comic.thumbnail)
        if viewContext.hasChanges {
            do { try viewContext.save() }
            catch { throw error }
        }
    }
    
    func deleteComic(_ comic: ComicResult) throws {
        let fetchRequest: NSFetchRequest<ComicsEntity> = ComicsEntity.fetchRequest()
        let predicate = NSPredicate(format: "comicName == %@", comic.title) // Condition used to constrain the search
        fetchRequest.predicate = predicate
        let comicEntities: [ComicsEntity]
        do {
            comicEntities = try viewContext.fetch(fetchRequest)
            comicEntities.forEach { (comicEntity) in
                viewContext.delete(comicEntity)
            }
            try viewContext.save()
        } catch { throw error }
    }
}

