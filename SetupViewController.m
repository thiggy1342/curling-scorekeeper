//
//  SetupViewController.m
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 4/3/17.
//  Copyright © 2017 Daniel Thigpen. All rights reserved.
//

#import "SetupViewController.h"

@interface SetupViewController ()

@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _redTeamNameField.delegate = self;
    _yellowTeamNameField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewController *mainViewController = (ViewController *)segue.destinationViewController;
    mainViewController.yellowTeamName = _yellowTeamNameField.text;
    mainViewController.redTeamName = _redTeamNameField.text;
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


@end
