//
//  Game.m
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/23/17.
//  Copyright © 2017 Daniel Thigpen. All rights reserved.
//

#import "Game.h"
#import "GameMO+CoreDataClass.h"

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

-(id)initWithManagedObject:(GameMO *)gameMO {
    self = super.init;
    if(self) {
        self.yellowScoreTotal   = gameMO.yellowScoreTotal;
        self.yellowScoreArray   = gameMO.yellowScoreArray;
        self.yellowTeamName     = gameMO.yellowTeamName;
        self.redScoreTotal      = gameMO.redScoreTotal;
        self.redScoreArray      = gameMO.redScoreArray;
        self.redTeamName        = gameMO.redTeamName;
        self.end                = gameMO.end;
        self.inProgress         = gameMO.inProgress;
        self.hasHammer          = gameMO.hasHammer;
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
    self.end++;
}

-(void)decrementEnd {
    // return early if we're already on the first end
    if(self.end == 1){ return; }
    
    // we can assume that a game with a decremented end will always need to be in progress
    self.inProgress = true;
    
    // set hammer based on the score from two ends ago
    self.hasHammer = [self getHammerAtEnd: self.end - 1];
    
    //clear end scores
    [self clearScoresAtEnd: self.end-1];
    
    // decrement the end
    self.end--;
}

-(void)clearScoresAtEnd:(int) end {
    int index = end-1;

    // clear from score total
    if([self.hasHammer isEqualToString:@"red"]){
        self.yellowScoreTotal -= [self.yellowScoreArray[index] intValue];
    } else if([self.hasHammer isEqualToString:@"yellow"]){
        self.redScoreTotal -= [self.redScoreArray[index] intValue];
    }
    
    //clear scores from table
    [self.yellowScoreArray removeObjectAtIndex:index];
    [self.redScoreArray removeObjectAtIndex:index];
}

-(NSString*)getHammerAtEnd:(int) end {
    int index = end - 1;
    if(end < 1 || end > 11){ return @""; }
    if([self.yellowScoreArray[index] integerValue] > 0){
        return @"red";
    } else if ([self.redScoreArray[index] integerValue] > 0){
        return @"yellow";
    } else {
        return [self getHammerAtEnd:end - 1];
    }
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
