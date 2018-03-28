//
//  Game.h
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/23/17.
//  Copyright © 2017 Daniel Thigpen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameMO;

@interface Game : NSObject

@property (nonatomic) bool inProgress;
@property (nonatomic) int yellowScoreTotal;
@property (nonatomic, strong) NSMutableArray *yellowScoreArray;
@property (nonatomic) int redScoreTotal;
@property (nonatomic, strong) NSMutableArray *redScoreArray;
@property (nonatomic, strong) NSString *yellowTeamName;
@property (nonatomic, strong) NSString *redTeamName;
@property (nonatomic) int end;
@property (strong, nonatomic) NSString *hasHammer;

-(void)finishEnd:(int) redPointsScored :(int) yellowPointsScored;
-(void)incrementEnd;
-(NSString*)currentlyLeading;
-(id)initWithManagedObject: (GameMO*)gameMO;

@end
