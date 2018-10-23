//
//  EditGameDetailsViewController.m
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 10/16/18.
//  Copyright © 2018 Daniel Thigpen. All rights reserved.
//

#import "EditGameDetailsViewController.h"

@interface EditGameDetailsViewController ()
@property (strong, nonatomic) UINotificationFeedbackGenerator *notificationFeedback;
@property (strong, nonatomic) NSString *nameTooShortMessage;
@property (strong, nonatomic) NSString *nameTooLongMessage;
@end

@implementation EditGameDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set view title
    self.navigationItem.title = @"Game Details";
    // set text view border
    [self setTextFieldStyles];
    // init haptic feedback objects
    self.notificationFeedback = [[UINotificationFeedbackGenerator alloc] init];
    // set up team name error messages
    [self.teamNameMessageLabel setText: @""];
    self.nameTooShortMessage = @"Cannot leave name blank";
    self.nameTooLongMessage = @"Name must be less than 25 characters";
    // set existing values
    [self.yellowTeamNameField setText:_gameMO.yellowTeamName];
    [self.redTeamNameField setText:_gameMO.redTeamName];
    if(self.gameMO.gameName) {
        [self.gameNameField setText:self.gameMO.gameName];
    }
    if(self.gameMO.gameNotes) {
        [self.gameNotesField setText:self.gameMO.gameNotes];
    }
}

-(void)validateNameFields {
    if ([self.redTeamNameField.text length] < 1 || [self.yellowTeamNameField.text length] < 1) {
        [self.teamNameMessageLabel setText: self.nameTooShortMessage];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    } else if ([self.redTeamNameField.text length] > 25 || [self.yellowTeamNameField.text length] > 25) {
        [self.teamNameMessageLabel setText: self.nameTooLongMessage];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    } else {
        [self.teamNameMessageLabel setText:@""];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)setTextFieldStyles {
    // magic numbers
    int borderWidth = 1;
    int cornerRadius = 5;
    UIColor *borderColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
    
    //set border widths
    self.gameNameField.layer.borderWidth = borderWidth;
    self.gameNotesField.layer.borderWidth = borderWidth;
    self.yellowTeamNameField.layer.borderWidth = borderWidth;
    self.redTeamNameField.layer.borderWidth = borderWidth;
    //set border radii
    self.gameNameField.layer.cornerRadius = cornerRadius;
    self.gameNotesField.layer.cornerRadius = cornerRadius;
    self.yellowTeamNameField.layer.cornerRadius = cornerRadius;
    self.redTeamNameField.layer.cornerRadius = cornerRadius;
    //set border color
    self.gameNotesField.layer.borderColor = [borderColor CGColor];
    self.gameNameField.layer.borderColor = [borderColor CGColor];
    self.yellowTeamNameField.layer.borderColor = [borderColor CGColor];
    self.redTeamNameField.layer.borderColor = [borderColor CGColor];
}

#pragma mark - Field Action methods

- (IBAction)yellowTeamNameDoneEditing:(id)sender {
    [self validateNameFields];
}

- (IBAction)redTeamNameDoneEditing:(id)sender {
    [self validateNameFields];
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
        _gameMO.yellowTeamName = self.yellowTeamNameField.text;
        _gameMO.redTeamName = self.redTeamNameField.text;
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
