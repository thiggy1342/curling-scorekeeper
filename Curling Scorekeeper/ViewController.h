//
//  ViewController.h
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/21/17.
//  Copyright © 2017 Daniel Thigpen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameMO+CoreDataClass.h"
#import "Game.h"
#import "SetupViewController.h"
#import "GamesListTableViewController.h"
#import "DataController.h"

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>;

@property (strong, nonatomic) IBOutlet UILabel *yellowScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *redScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *yellowTempScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *redTempScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *yellowTeamLabel;
@property (strong, nonatomic) IBOutlet UILabel *redTeamLabel;
@property (strong, nonatomic) IBOutlet UILabel *finalScoreLabel;

@property (strong, nonatomic) GameMO *gameMO;
@property (strong, nonatomic) Game *game;
@property (nonatomic) int yellowTempScore;
@property (nonatomic) int redTempScore;
@property (nonatomic,strong) NSString *yellowTeamName;
@property (nonatomic, strong) NSString *redTeamName;
@property (strong, nonatomic) NSManagedObjectContext *context;

- (IBAction)incrementYellowTempScore:(id)sender;
- (IBAction)decrementYellowTempScore:(id)sender;
- (IBAction)incrementRedTempScore:(id)sender;
- (IBAction)decrementRedTempScore:(id)sender;
- (IBAction)finishEndButton:(id)sender;

@end

