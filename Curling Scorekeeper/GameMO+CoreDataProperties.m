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

-(void)awakeFromInsert {
    [super awakeFromInsert];
    self.dateCreated = [NSDate date];
}

-(void)updateFromGameInstance: (Game*) game {
        self.yellowTeamName     = game.yellowTeamName;
        self.yellowScoreTotal   = game.yellowScoreTotal;
        self.yellowScoreArray   = game.yellowScoreArray;
        self.redTeamName        = game.redTeamName;
        self.redScoreTotal      = game.redScoreTotal;
        self.redScoreArray      = game.redScoreArray;
        self.end                = game.end;
        self.hasHammer          = game.hasHammer;
        self.inProgress         = game.inProgress;
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
@dynamic gameName;
@dynamic gameNotes;

@end
