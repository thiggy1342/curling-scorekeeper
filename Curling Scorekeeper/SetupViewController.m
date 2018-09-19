//
//  SetupViewController.m
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 4/3/17.
//  Copyright © 2017 Daniel Thigpen. All rights reserved.
//

#import "SetupViewController.h"

@interface SetupViewController ()
@property (strong, nonatomic) UINotificationFeedbackGenerator *notificationFeedback;
@property (strong, nonatomic) NSString *nameTooShortMessage;
@property (strong, nonatomic) NSString *nameTooLongMessage;
@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.redTeamNameField.delegate = self;
    self.yellowTeamNameField.delegate = self;
    [self.startGameButton setEnabled:NO];
    self.navigationItem.title = @"Set Up Game";
    
    // init haptic feedback objects
    self.notificationFeedback = [[UINotificationFeedbackGenerator alloc] init];
    
    // set error messages and clear error labels
    [self.teamNameMessageLabel setText: @""];
    self.nameTooShortMessage = @"Cannot leave name blank";
    self.nameTooLongMessage = @"Name must be less than 25 characters";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //setupNewGameSegue
    if ([segue.identifier isEqualToString:@"setupNewGameSegue"]) {
        ViewController *destController = segue.destinationViewController;
        destController.context = _context;
        destController.yellowTeamName = _yellowTeamNameField.text;
        destController.redTeamName = _redTeamNameField.text;
    }
    
    //cancelCreateSegue
    if ([segue.identifier isEqualToString:@"cancelCreateSegue"]){
        GamesListTableViewController *destController = segue.destinationViewController;
        destController.context = _context;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)team1NameEditingDidEnd:(UITextField *)sender {
    [self validateNameFields];
}


- (IBAction)team2NameEditingDidEnd:(UITextField *)sender {
    [self validateNameFields];
}

-(void)validateNameFields {
    if ([self.redTeamNameField.text length] < 1 || [self.yellowTeamNameField.text length] < 1) {
        [self.teamNameMessageLabel setText: self.nameTooShortMessage];
    } else if ([self.redTeamNameField.text length] > 25 || [self.yellowTeamNameField.text length] > 25) {
        [self.teamNameMessageLabel setText: self.nameTooLongMessage];
    } else {
        [self.teamNameMessageLabel setText:@""];
        [self.startGameButton setEnabled:YES];
        [self.startGameButton setBackgroundColor: [UIColor colorWithRed:0.00 green:0.84 blue:0.27 alpha:1.0]];
    }
}

- (IBAction)startGameButton:(id)sender {
    [self.notificationFeedback notificationOccurred:UINotificationFeedbackTypeSuccess];
}
@end
