//
//  Game.h
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/23/17.
//  Copyright © 2017 Daniel Thigpen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Score.h"

@interface Game : NSObject

@property (nonatomic) bool inProgress;
@property (strong, nonatomic) Score *yellowScore;
@property (strong, nonatomic) Score *redScore;
@property (nonatomic) int end;
@property (strong, nonatomic) NSString *hasHammer;

//-(void)finishEnd:(NSString*) scoringTeam :(int) pointsScored;
-(void)finishEnd:(int) redPointsScored :(int) yellowPointsScored;
-(void)incrementEnd;
-(NSString*)currentlyLeading;

@end
