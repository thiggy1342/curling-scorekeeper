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

-(void)finishEnd:(NSString*) scoringTeam :(int) pointsScored {
    if([scoringTeam isEqual: @"yellow"]){
        [self.yellowScore addToScore:pointsScored AtEnd:self.end];
        [self.redScore addToScore:0 AtEnd:self.end];
        if(pointsScored > 0){
            self.hasHammer = @"red";
        }
    } else if ([scoringTeam isEqual:@"red"]){
        [self.redScore addToScore:pointsScored AtEnd:self.end];
        [self.yellowScore addToScore:0 AtEnd:self.end];
        if(pointsScored > 0){
            self.hasHammer = @"yellow";
        }
    }
    [self incrementEnd];
}

-(void)incrementEnd {
    if(self.end == 10){
        self.inProgress = false;
    } else {
        self.end ++;
    }
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
