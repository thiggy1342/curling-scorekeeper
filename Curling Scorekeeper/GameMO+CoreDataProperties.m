//
//  GameMO+CoreDataProperties.m
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/27/18.
//  Copyright © 2018 Daniel Thigpen. All rights reserved.
//
//

#import "GameMO+CoreDataProperties.h"

@implementation GameMO (CoreDataProperties)

+ (NSFetchRequest<GameMO *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Game"];
}

@dynamic dateCreated;
@dynamic dateUpdated;
@dynamic end;
@dynamic hasHammer;
@dynamic inProgress;
@dynamic redTeamName;
@dynamic redScoreTotal;
@dynamic redScoreArray;
@dynamic yellowTeamName;
@dynamic yellowScoreTotal;
@dynamic yellowScoreArray;

@end
