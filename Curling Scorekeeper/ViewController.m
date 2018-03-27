//
//  ViewController.m
//  Curling Scorekeeper
//
//  Created by Adam Thigpen on 3/21/17.
//  Copyright © 2017 Daniel Thigpen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *scoreBoardArray;
@property (nonatomic, strong) DataController *dataController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataController = [[DataController alloc]init];
    self.context = [_dataController managedObjectContext];
    
    UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(50.0, 50.0)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView setPagingEnabled:NO];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    [self setupNewGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SETUP METHOD
-(void)setupNewGame{
    // setup new game object
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"GameMO" inManagedObjectContext:_context];
    self.gameMO = [[GameMO alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:_context];
    
    //setup the game
    self.game = [[Game alloc]init];
    self.game.yellowTeamName = _yellowTeamName;
    self.game.redTeamName = _redTeamName;
    
    //setup the ui
    [self initScoreBoardArray];
    [self.yellowTeamLabel setText: self.game.yellowTeamName];
    [self.redTeamLabel setText: self.game.redTeamName];
    [self updateDisplay];
}

#pragma mark - BUTTON ACTION METHODS
- (IBAction)finishEndButton:(id)sender {
    if(self.game.inProgress){
        [self.game finishEnd: _redTempScore :_yellowTempScore];
        if(self.redTempScore == self.yellowTempScore == 0){
            [self updateScoreBoard];
        }
        [self updateDisplay];
    } else {
        [self.finalScoreLabel setText: @"Final"];
        [self showGameOverAlert];
    }
}

- (IBAction)save:(id)sender {
    // Jankily assigning game model values to the managed object
    _gameMO.yellowTeamName = _game.yellowTeamName;
    _gameMO.yellowScoreTotal = _game.yellowScoreTotal;
    _gameMO.yellowScoreArray = _game.yellowScoreArray;
    _gameMO.redTeamName = _game.redTeamName;
    _gameMO.redScoreTotal = _game.redScoreTotal;
    _gameMO.redScoreArray = _game.redScoreArray;
    _gameMO.end = _game.end;
    _gameMO.hasHammer = _game.hasHammer;
    _gameMO.inProgress = _game.inProgress;
    
    // Saving changes in the context
    NSError *error = nil;
    [[_dataController managedObjectContext] save:&error];
    if (error) {
        NSLog(@"output:%@", error);
    }
}

- (IBAction)resetButton:(id)sender {
    [self setupNewGame];
}

- (IBAction)incrementRedTempScore:(id)sender {
    if(self.redTempScore < 8){
        self.redTempScore++;
        self.yellowTempScore = 0;
        [self updateTempScore];
    }
}

- (IBAction)decrementRedTempScore:(id)sender {
    if(self.redTempScore > 0){
        self.redTempScore--;
        [self updateTempScore];
    }
}

- (IBAction)incrementYellowTempScore:(id)sender {
    if(self.yellowTempScore < 8){
        self.yellowTempScore++;
        self.redTempScore = 0;
        [self updateTempScore];
    }
}

- (IBAction)decrementYellowTempScore:(id)sender {
    if(self.yellowTempScore > 0){
        self.yellowTempScore--;
        [self updateTempScore];
    }
}

#pragma mark - SCOREBOARD METHODS
-(void)initScoreBoardArray{
    self.scoreBoardArray = [[NSMutableArray alloc] init];
    NSMutableArray *teamLabelArray = [[NSMutableArray alloc] initWithObjects:@"",@"H",@"", nil];
    [self.scoreBoardArray addObject:teamLabelArray];
    for (int i = 1; i < 13; i++){
        NSString *columnNumber = [NSString stringWithFormat:@"%i", i];
        NSMutableArray *columnArray = [[NSMutableArray alloc] initWithObjects:@"",columnNumber,@"", nil];
        [self.scoreBoardArray insertObject:columnArray atIndex:i];
    }
}

-(void)updateScoreBoard {
    int scoreRow;
    int hammerRow;
    NSString *hammerString = @"🔨";
    int totalScore;
    if ([self.game.hasHammer isEqualToString:@"red"]){
        scoreRow = 0;
        hammerRow = 2;
        totalScore = self.game.yellowScoreTotal;
    } else {
        scoreRow = 2;
        hammerRow = 0;
        totalScore = self.game.redScoreTotal;
    }
    
    // extends scoreboard if score is going to be larger than currently displayed
    [self extendScoreboardTo: totalScore];
    
    [self.scoreBoardArray[totalScore] replaceObjectAtIndex:scoreRow withObject:[NSString stringWithFormat:@"%i",self.game.end-1]];
    [self.scoreBoardArray[0] replaceObjectAtIndex:scoreRow withObject:@""];
    [self.scoreBoardArray[0] replaceObjectAtIndex:hammerRow withObject:hammerString];
}

-(void)extendScoreboardTo:(int) totalColumns {
    int currentColumns = [self.scoreBoardArray count];
    if(totalColumns > currentColumns - 1){
        for (int i = currentColumns; i < totalColumns + 1; i++){
            NSString *columnNumber = [NSString stringWithFormat:@"%i", i];
            NSMutableArray *columnArray = [[NSMutableArray alloc] initWithObjects:@"",columnNumber,@"", nil];
            [self.scoreBoardArray insertObject:columnArray atIndex:i];
        }
        [self updateDisplay];
    }
}

#pragma mark - OTHER DISPLAY METHODS
- (void)updateDisplay {
    [_yellowScoreLabel setText: [NSString stringWithFormat:@"%i",self.game.yellowScoreTotal]];
    [_redScoreLabel setText: [NSString stringWithFormat:@"%i",self.game.redScoreTotal]];
    [self.collectionView reloadData];
    [self resetTempScore];
}

-(void)updateTempScore{
    [self.yellowTempScoreLabel setText: [NSString stringWithFormat:@"%i", self.yellowTempScore]];
    [self.redTempScoreLabel setText:[NSString stringWithFormat:@"%i", self.redTempScore]];
}

-(void)resetTempScore{
    self.yellowTempScore = 0;
    self.redTempScore = 0;
    [self.yellowTempScoreLabel setText:@"0"];
    [self.redTempScoreLabel setText:@"0"];
}

-(void)showGameOverAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game Over!" message:@"Tap \"New Game\" to play again" preferredStyle:UIAlertViewStyleDefault];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                NSLog(@"You pressed dismiss");
                                                            }];
    [alert addAction:dismissAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - SEGUE METHODS
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"viewSavedSegue"]) {
        UINavigationController *navController = segue.destinationViewController;
        GamesListTableViewController *destController = navController.topViewController;
        destController.context = _context;
    }
}

#pragma mark - COLLECTIONVIEW METHODS
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.scoreBoardArray count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray *sectionArray = [self.scoreBoardArray objectAtIndex:section];
    return [sectionArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSMutableArray *data = [self.scoreBoardArray objectAtIndex:indexPath.section];
    NSString *cellData = [data objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"cvCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    [titleLabel setText:cellData];
    
    UIColor *cellColor = [[UIColor alloc]init];
    if(indexPath.row == 0){
        cellColor = [UIColor yellowColor];
    } else if (indexPath.row == 1){
        cellColor = [UIColor whiteColor];
    } else if (indexPath.row == 2){
        cellColor = [UIColor redColor];
    }
    cell.backgroundColor = cellColor;
    
    return cell;
}
@end
