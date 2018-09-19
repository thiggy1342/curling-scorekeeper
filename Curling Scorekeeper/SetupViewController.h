//
//  SetupViewController.h
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 4/3/17.
//  Copyright © 2017 Daniel Thigpen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ViewController.h"

@interface SetupViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *yellowTeamNameField;
@property (strong, nonatomic) IBOutlet UITextField *redTeamNameField;
@property (strong, nonatomic) IBOutlet UILabel *teamNameMessageLabel;
@property (strong, nonatomic) IBOutlet UIButton *startGameButton;
- (IBAction)startGameButton:(id)sender;

@property (nonatomic, strong) NSString *yellowTeamName;
@property (nonatomic, strong) NSString *redTeamName;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end
