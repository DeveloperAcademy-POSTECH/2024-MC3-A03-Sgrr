////
////  CoreDataManager.swift
////  Lvlance
////
////  Created by 지영 on 7/27/24.
////
//
//import CoreData
//import Foundation
//
//class CoreDataManager {
//    static let shared = CoreDataManager()
//    lazy var persistentContainer: NSPersistentContainer = {
//        
//        let container = NSPersistentContainer(name: "BandSong")
//        
//        container.loadPersistentStores { _, error in
//            if let error {
//                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
//            }
//        }
//        return container
//    }()
//    
//    var context: NSManagedObjectContext {
//        return self.persistentContainer.viewContext
//    }
//    
//    
//    func save() {
//        guard context.hasChanges else { return }
//        
//        do  {
//            try context.save()
//            print("context에 데이터 저장")
//        } catch {
//            print("context에 저장 실패:", error.localizedDescription)
//        }
//    }
//    
//    //TODO: 새 노래 뒤에 번호 붙이기
//    func createSongEntity(instruments: [Instrument]) {
//        let newSong = SongEntity(context: context)
//        newSong.id = UUID()
//        newSong.date = Date()
//        newSong.title = "새 노래"
//        
//        for instrument in instruments {
//            let newInstrument = InstrumentEntity(context: context)
//            newInstrument.type = instrument.type.rawValue
//            newSong.addToInstruments(newInstrument)
//        }
//        save()
//    }
//    
//    //entity의 식별자를 파라미터로 받아서 찾아와
//    func fetchEntityID(song: Song) -> SongEntity? {
//        let id = song.id
//        let request = SongEntity.fetchRequest()
//        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
//        request.fetchLimit = 1
//        
//        do {
//            let results = try context.fetch(request)
//            return results.first
//        } catch {
//            print("id값 가져오기 실패: \(error.localizedDescription)")
//            return nil
//        }
//    }
//    
//    func fetchAllSongEntities() -> [SongEntity] {
//        do {
//            let request = SongEntity.fetchRequest()
//            request.sortDescriptors = [NSSortDescriptor(keyPath: \SongEntity.date, ascending: false)]
//            let results = try context.fetch(request)
//            return results
//        } catch {
//            print("데이터 불러오기 실패: \(error.localizedDescription)")
//        }
//        return []
//    }
//    
//    func getAllSongs() -> [Song] {
//        var songs: [Song] = []
//        let fetchResults = fetchAllSongEntities()
//        for entity in fetchResults {
//            let id = entity.id ?? UUID()
//            let title = entity.title ?? "새 노래"
//            var instruments: [Instrument] = []
//            
//            if let instrumentEntities = entity.instruments as? Set<InstrumentEntity> {
//                for instrumentEntity in instrumentEntities {
//                    if let entityType = instrumentEntity.type,
//                       let type = InstrumentType(rawValue: entityType) {
//                        let instrument = Instrument(type: type)
//                        instruments.append(instrument)
//                    }
//                }
//            }
//            let song = Song(id: id, title: title, instruments: instruments)
//            songs.append(song)
//        }
//        return songs
//    }
//    
//    func updateSongEntity(song: Song, title: String? = nil, instruments: [Instrument]? = nil) {
//        let entity = fetchEntityID(song: song)
//        
//        if let title = title {
//            entity?.title = title
//        }
//        
//        
//        if let instruments = entity?.instruments as? Set<InstrumentEntity> {
//            entity?.removeFromInstruments(instruments as NSSet)
//        }
//        
//        if let instruments = instruments {
//            for instrument in instruments {
//                let newInstrument = InstrumentEntity(context: context)
//                newInstrument.type = instrument.type.rawValue
//                entity?.addToInstruments(newInstrument)
//            }
//        }
//        save()
//    }
//    
//    func deleteSongEntity(song: Song) {
//        if let entity = fetchEntityID(song: song) {
//            context.delete(entity)
//            save()
//        }
//    }
//}
