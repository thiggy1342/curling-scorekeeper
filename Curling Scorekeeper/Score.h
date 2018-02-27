//
//  Score.h
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/23/17.
//  Copyright © 2017 Daniel Thigpen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

@property (nonatomic) int totalScore;
@property (nonatomic, strong) NSMutableArray *scoreArray;

-(void)addToScore:(int)toAdd AtEnd:(int)end;
-(int)getScoreAtEnd:(int)end;

@end
