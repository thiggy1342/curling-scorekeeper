//
//  EditGameDetailsViewController.h
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 10/16/18.
//  Copyright © 2018 Daniel Thigpen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "GameMO+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditGameDetailsViewController : UIViewController
@property (nonatomic, strong)GameMO *gameMO;
@property (nonatomic, strong)NSManagedObjectContext *context;
@property (strong, nonatomic) IBOutlet UITextField *gameNameField;
@property (strong, nonatomic) IBOutlet UITextView *gameNotesField;
@end

NS_ASSUME_NONNULL_END
