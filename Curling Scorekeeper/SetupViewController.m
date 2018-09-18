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
@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.redTeamNameField.delegate = self;
    self.yellowTeamNameField.delegate = self;
    self.navigationItem.title = @"Set Up Game";
    
    // init haptic feedback objects
    self.notificationFeedback = [[UINotificationFeedbackGenerator alloc] init];
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

- (IBAction)startGameButton:(id)sender {
    [self.notificationFeedback notificationOccurred:UINotificationFeedbackTypeSuccess];
}
@end
