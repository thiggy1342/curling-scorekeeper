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
        self.yellowScore = [[Score alloc]init];
        self.redScore = [[Score alloc]init];
        self.end = 1;
        self.inProgress = true;
        self.hasHammer = @"yellow";
    }
    return self;
}

//-(void)finishEnd:(NSString*) scoringTeam :(int) pointsScored {
//    if([scoringTeam isEqual: @"yellow"]){
//        [self.yellowScore addToScore:pointsScored AtEnd:self.end];
//        [self.redScore addToScore:0 AtEnd:self.end];
//        if(pointsScored > 0){
//            self.hasHammer = @"red";
//        }
//    } else if ([scoringTeam isEqual:@"red"]){
//        [self.redScore addToScore:pointsScored AtEnd:self.end];
//        [self.yellowScore addToScore:0 AtEnd:self.end];
//        if(pointsScored > 0){
//            self.hasHammer = @"yellow";
//        }
//    }
//    [self incrementEnd];
//}

-(void)finishEnd:(int) redPointsScored :(int) yellowPointsScored {
    // Update scores
    [self.yellowScore addToScore:yellowPointsScored AtEnd:self.end];
    [self.redScore addToScore:redPointsScored AtEnd:self.end];
    
    // Update hammer
    [self updateHammer:redPointsScored :yellowPointsScored];
    
    // Update end
    [self incrementEnd];
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
    if((self.end == 10 && self.yellowScore.totalScore != self.redScore.totalScore) || self.end == 11){
        self.inProgress = false;
    }
    self.end ++;
}

-(NSString*)currentlyLeading {
    if(self.yellowScore > self.redScore){
        return @"yellow";
    } else if (self.redScore > self.yellowScore){
        return @"red";
    } else {
        return @"tie";
    }
}

@end
