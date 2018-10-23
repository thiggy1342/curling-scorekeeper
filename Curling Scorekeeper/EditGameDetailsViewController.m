//
//  EditGameDetailsViewController.m
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 10/16/18.
//  Copyright © 2018 Daniel Thigpen. All rights reserved.
//

#import "EditGameDetailsViewController.h"

@interface EditGameDetailsViewController ()

@end

@implementation EditGameDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set view title
    self.navigationItem.title = @"Game Details";
    if(self.gameMO.gameName) {
        [self.gameNameField setText:self.gameMO.gameName];
    }
    if(self.gameMO.gameNotes) {
        [self.gameNotesField setText:self.gameMO.gameNotes];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"cancelEditGameDetailsSegue"]) {
        ViewController *destController = segue.destinationViewController;
        destController.context = _context;
        destController.gameMO = _gameMO;
    } else if([segue.identifier
        isEqualToString:@"saveEditGameDetailsSegue"]) {
        // save what's currently in the fields
        _gameMO.gameName = self.gameNameField.text;
        _gameMO.gameNotes = self.gameNotesField.text;
        // save the managed objects
        NSError *error = nil;
        [_context save:&error];
        if(error){
            NSLog(@"Unable to save game: %@", error.description);
        }
        // push gameMO and the context to the scoreboard view
        ViewController *destController = segue.destinationViewController;
        destController.context = _context;
        destController.gameMO = _gameMO;
    }
}


@end
