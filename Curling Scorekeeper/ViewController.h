//
//  ViewController.h
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/21/17.
//  Copyright © 2017 Daniel Thigpen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Score.h"
#import "SetupViewController.h"

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>;

@property (strong, nonatomic) IBOutlet UILabel *yellowScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *redScoreLabel;
@property (strong, nonatomic) Game *game;
@property (strong, nonatomic) IBOutlet UILabel *yellowTempScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *redTempScoreLabel;
@property (nonatomic) int yellowTempScore;
@property (nonatomic) int redTempScore;

@property (nonatomic,strong) NSString *yellowTeamName;
@property (strong, nonatomic) IBOutlet UILabel *yellowTeamLabel;
@property (nonatomic, strong) NSString *redTeamName;
@property (strong, nonatomic) IBOutlet UILabel *redTeamLabel;


- (IBAction)incrementYellowTempScore:(id)sender;
- (IBAction)decrementYellowTempScore:(id)sender;

- (IBAction)incrementRedTempScore:(id)sender;
- (IBAction)decrementRedTempScore:(id)sender;

- (IBAction)finishEndButton:(id)sender;

@end

