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

@interface EditGameDetailsViewController : UIViewController<UITextViewDelegate>
@property (nonatomic, strong)GameMO *gameMO;
@property (nonatomic, strong)NSManagedObjectContext *context;
@property (strong, nonatomic) IBOutlet UITextField *yellowTeamNameField;
@property (strong, nonatomic) IBOutlet UITextField *redTeamNameField;
@property (strong, nonatomic) IBOutlet UILabel *teamNameMessageLabel;
@property (strong, nonatomic) IBOutlet UITextField *gameNameField;
@property (strong, nonatomic) IBOutlet UITextView *gameNotesField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)yellowTeamNameDoneEditing:(id)sender;
- (IBAction)redTeamNameDoneEditing:(id)sender;
@end

NS_ASSUME_NONNULL_END
