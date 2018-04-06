//
//  DataController.m
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/27/18.
//  Copyright © 2018 Daniel Thigpen. All rights reserved.
//

#import "DataController.h"

@implementation DataController

- (id)init
{
    self = [super init];
    if (!self) return nil;
    
    self.persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CurlingScorekeeper"];
    [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *description, NSError *error) {
        if (error != nil) {
            NSLog(@"Failed to load Core Data stack: %@", error);
            abort();
        }
    }];
    return self;
}

-(NSManagedObjectContext*)managedObjectContext {
    return [self.persistentContainer viewContext];
}

@end
