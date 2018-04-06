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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up context if not defined
    if (!_context) {
        DataController *dataController = [[DataController alloc]init];
        self.context = [dataController managedObjectContext];
    }
    
    // set up collection view for scoreboard
    UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(50.0, 50.0)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView setPagingEnabled:NO];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    // set up new game if one doesn't exist, otherwise load saved game
    if (!_gameMO) {
       [self setupNewGame];
    } else {
        [self loadSavedGame];
    }
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
    
    //setup scoreboard
    [self initScoreBoardArray];
    
    //setup the ui
    [self initializeUI];
}

-(void)loadSavedGame {
    self.game = [[Game alloc] initWithManagedObject: _gameMO];
    [self initScoreBoardArray];
    [self populateScoreBoardArrayFromSavedGame];
    [self initializeUI];
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

-(void)populateScoreBoardArrayFromSavedGame {
    // extend the scoreboard to the largest size before we modify the data source
    [self extendScoreboardTo:MAX(_game.yellowScoreTotal,_game.redScoreTotal)];
    
    // sets the hammer indicator for the current end
    [self updateHammerIndicator];
    
    int runningYellowScore = 0;
    int runningRedScore = 0;
    for(int i = 0; i < _game.yellowScoreArray.count; i++){
        int yellowEndScore = [_game.yellowScoreArray[i] intValue];
        int redEndScore = [_game.redScoreArray[i] intValue];
        if (yellowEndScore > redEndScore) {
            runningYellowScore += yellowEndScore;
            NSMutableArray *workingColumn = _scoreBoardArray[runningYellowScore];
            [workingColumn replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%i",i+1]];
        } else if (redEndScore > yellowEndScore) {
            runningRedScore += redEndScore;
            NSMutableArray *workingColumn = _scoreBoardArray[runningRedScore];
            [workingColumn replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%i",i+1]];
        }
    }
}

-(void)updateHammerIndicator {
    int hammerRow;
    int noHammerRow;
    NSString *hammerString = @"🔨";
    
    // determine which row to place the hammerString on
    if([_game.hasHammer isEqualToString:@"red"]){
        // Red scores and hammer are on the bottom row of the scoreboard
        hammerRow = 2;
        noHammerRow = 0;
    } else {
        // Yellow scores and hammer are on the top row of the scoreboard
        hammerRow = 0;
        noHammerRow = 2;
    }
    
    // remove the hammer from the row that doesn't have hammer
    [self.scoreBoardArray[0] replaceObjectAtIndex:noHammerRow withObject:@""];\
    // and add it to the row that does
    [self.scoreBoardArray[0] replaceObjectAtIndex:hammerRow withObject:hammerString];
}

-(void)updateScoreBoard {
    int scoreRow;
    int totalScore;
    
    // determine scoring team by the team that doesn't have hammer
    if ([self.game.hasHammer isEqualToString:@"red"]){
        scoreRow = 0;
        totalScore = self.game.yellowScoreTotal;
    } else {
        scoreRow = 2;
        totalScore = self.game.redScoreTotal;
    }
    
    // extends scoreboard if score is going to be larger than currently displayed
    [self extendScoreboardTo: totalScore];
    
    // update the hammer indicator
    [self updateHammerIndicator];
    
    [self.scoreBoardArray[totalScore] replaceObjectAtIndex:scoreRow withObject:[NSString stringWithFormat:@"%i",self.game.end-1]];
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
-(void)initializeUI {
    [self.yellowTeamLabel setText: self.game.yellowTeamName];
    [self.redTeamLabel setText: self.game.redTeamName];
    [self updateDisplay];
}

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
    if ([segue.identifier isEqualToString:@"doneSegue"]) {
        // Update GameMO values before save
        [_gameMO updateFromGameInstance: _game];
        NSError *error = nil;
        [_context save:&error];
        if(error){
            NSLog(@"Unable to save game: %@", error.description);
        }
        GamesListTableViewController *destController = segue.destinationViewController;
        destController.context = _context;
    }
}

#pragma mark - COLLECTIONVIEW METHODS
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.scoreBoardArray count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray *sectionArray = [_scoreBoardArray objectAtIndex:section];
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
