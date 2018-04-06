//
//  GameMO+CoreDataProperties.h
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/27/18.
//  Copyright © 2018 Daniel Thigpen. All rights reserved.
//
//

#import "GameMO+CoreDataClass.h"
@class Game;


NS_ASSUME_NONNULL_BEGIN

@interface GameMO (CoreDataProperties)

+ (NSFetchRequest<GameMO *> *)fetchRequest;

-(void)updateFromGameInstance: (Game*) game;

@property (nullable, nonatomic, copy) NSDate *dateCreated;
@property (nullable, nonatomic, copy) NSDate *dateUpdated;
@property (nonatomic) int16_t end;
@property (nullable, nonatomic, copy) NSString *hasHammer;
@property (nonatomic) BOOL inProgress;
@property (nullable, nonatomic, copy) NSString *redTeamName;
@property (nonatomic) int16_t redScoreTotal;
@property (nullable, nonatomic, retain) NSMutableArray *redScoreArray;
@property (nullable, nonatomic, copy) NSString *yellowTeamName;
@property (nonatomic) int16_t yellowScoreTotal;
@property (nullable, nonatomic, retain) NSMutableArray *yellowScoreArray;

@end

NS_ASSUME_NONNULL_END
