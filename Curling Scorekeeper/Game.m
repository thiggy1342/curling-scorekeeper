//
//  Game.m
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/23/17.
//  Copyright © 2017 Daniel Thigpen. All rights reserved.
//

#import "Game.h"

@implementation Game

-(id)init
{
    self = super.init;
    if(self){
        self.yellowScoreTotal = 0;
        self.yellowScoreArray = [[NSMutableArray alloc] init];
        self.redScoreTotal = 0;
        self.redScoreArray = [[NSMutableArray alloc] init];
        self.end = 1;
        self.inProgress = true;
        self.hasHammer = @"yellow";
    }
    return self;
}

-(void)finishEnd:(int) redPointsScored :(int) yellowPointsScored {
    // Update scores
    [self addToYellowScore:yellowPointsScored];
    [self addToRedScore:redPointsScored];
    
    // Update hammer
    [self updateHammer:redPointsScored :yellowPointsScored];
    
    // Update end
    [self incrementEnd];
}

-(void)addToYellowScore:(int)toAdd {
    NSNumber *tempScore = [NSNumber numberWithInt:toAdd];
    int index = self.end-1;
    self.yellowScoreArray[index] = tempScore;
    self.yellowScoreTotal += [tempScore integerValue];
}

-(void)addToRedScore:(int)toAdd {
    NSNumber *tempScore = [NSNumber numberWithInt:toAdd];
    int index = self.end-1;
    self.redScoreArray[index] = tempScore;
    self.redScoreTotal += [tempScore integerValue];
}

-(void)updateHammer:(int) redPointsScored :(int) yellowPointsScored {
    NSString *hammerTeam = @"";
    if(redPointsScored > yellowPointsScored){
        hammerTeam = @"yellow";
    } else if(redPointsScored < yellowPointsScored){
        hammerTeam = @"red";
    } else {
        hammerTeam = self.hasHammer;
    }
    self.hasHammer = hammerTeam;
}

-(void)incrementEnd {
    if((self.end == 10 && self.yellowScoreTotal != self.redScoreTotal) || self.end == 11){
        self.inProgress = false;
    }
    self.end ++;
}

-(NSString*)currentlyLeading {
    if(self.yellowScoreTotal > self.redScoreTotal){
        return @"yellow";
    } else if (self.redScoreTotal > self.yellowScoreTotal){
        return @"red";
    } else {
        return @"tie";
    }
}

@end
