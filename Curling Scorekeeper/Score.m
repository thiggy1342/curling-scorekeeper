//
//  Score.m
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/23/17.
//  Copyright © 2017 Daniel Thigpen. All rights reserved.
//

#import "Score.h"

@implementation Score

-(id)init{
    self = super.init;
    if(self){
        self.totalScore = 0;
        self.scoreArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addToScore:(int)toAdd AtEnd:(int)end {
    NSNumber *tempScore = [NSNumber numberWithInt:toAdd];
    int index = end-1;
    self.scoreArray[index] = tempScore;
    self.totalScore = [self totalScore];
}

-(int)getScoreAtEnd:(int) end {
    int index = end-1;
    int score = [[self.scoreArray objectAtIndex: index] integerValue];
    return score;
}

-(int)totalScore {
    int totalScore = 0;
    for (NSNumber *endScore in self.scoreArray) {
        totalScore += [endScore integerValue];
    }
    return totalScore;
}

@end
