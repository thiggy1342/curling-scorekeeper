//
//  GamesListTableViewController.m
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/27/18.
//  Copyright © 2018 Daniel Thigpen. All rights reserved.
//

#import "GamesListTableViewController.h"

@interface GamesListTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation GamesListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //create new context if one doesn't already exist
    if (!_context) {
        DataController *dataController = [[DataController alloc]init];
        self.context = [dataController managedObjectContext];
    }
    
    // fetch data for load

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GameMO"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"dateCreated" ascending:YES]];
    NSError *error = nil;
    NSMutableArray *response = [[_context executeFetchRequest:request error:&error] mutableCopy];
    if (error) {
        NSLog(@"Failed to fetch for this reason: %@",error.description);
    }
    _gamesArray = response;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_gamesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameCell" forIndexPath:indexPath];
    GameMO *gameMO = _gamesArray[indexPath.row];
    NSString *label = [NSString stringWithFormat:@"%@ vs %@", gameMO.yellowTeamName, gameMO.redTeamName];
    cell.textLabel.text = label;
 
    return cell;
}
 
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // delete from context
        [self deleteGameAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(void)deleteGameAtIndex:(NSInteger*) index {
    GameMO *gameMO = [_gamesArray objectAtIndex: index];
    [_context deleteObject:gameMO];
    NSError *error = nil;
    [_context save:&error];
    if (error) {
        NSLog(@"Error deleting GameMO: %@",error.description);
    }
    [_gamesArray removeObjectAtIndex:index];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - SEGUE METHODS
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addGameSegue"]) {
        SetupViewController *destController = segue.destinationViewController;
        destController.context = _context;
    }
    if ([segue.identifier isEqualToString:@"viewSavedGameSegue"]) {
        ViewController *destController = segue.destinationViewController;
        destController.context = _context;
        GameMO *gameMO = [_gamesArray objectAtIndex: [self.tableView indexPathForSelectedRow].row];
        destController.gameMO = gameMO;
    }
}
@end
