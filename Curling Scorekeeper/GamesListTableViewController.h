//
//  GamesListTableViewController.h
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/27/18.
//  Copyright © 2018 Daniel Thigpen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GameMO+CoreDataClass.h"
#import "SetupViewController.h"

@interface GamesListTableViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSArray *gamesArray;

@end
