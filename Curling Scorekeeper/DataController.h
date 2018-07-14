//
//  DataController.h
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/27/18.
//  Copyright © 2018 Daniel Thigpen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataController : NSObject

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

-(NSManagedObjectContext*)managedObjectContext;

@end
