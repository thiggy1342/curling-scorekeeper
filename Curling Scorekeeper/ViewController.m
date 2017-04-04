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
    
    UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(50.0, 50.0)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView setPagingEnabled:NO];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    [self setupNewGame];
}

-(void)setupNewGame{
    self.game = [[Game alloc] init];
    [self initScoreBoardArray];
    [self updateDisplay];
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)finishEndButton:(id)sender {
    if(!self.game.inProgress){
    }
    int currentEnd = self.game.end;
    NSString *scoringTeam = @"";
    int tempScore = 0;
    if(self.redTempScore > self.yellowTempScore || (self.redTempScore == self.yellowTempScore && [self.game.hasHammer isEqual:@"red"])){
        scoringTeam = @"red";
        tempScore = self.redTempScore;
    } else if (self.yellowTempScore > self.redTempScore || (self.yellowTempScore == self.redTempScore && [self.game.hasHammer isEqual:@"yellow"])){
        scoringTeam = @"yellow";
        tempScore = self.yellowTempScore;
    }
    [self.game finishEnd:scoringTeam : tempScore];
    [self updateScoreBoard:scoringTeam :currentEnd];
    [self updateDisplay];
}
- (IBAction)resetButton:(id)sender {
    [self setupNewGame];
}

-(void)updateScoreBoard: (NSString*)scoringTeam : (int)end {
    int row;
    int hammerRow;
    NSString *hammerString = @"*";
    int totalScore;
    if ([scoringTeam isEqualToString:@"yellow"]){
        row = 0;
        hammerRow = 2;
        totalScore = self.game.yellowScore.totalScore;
    } else {
        row = 2;
        hammerRow = 0;
        totalScore = self.game.redScore.totalScore;
    }
    [self.scoreBoardArray[totalScore] replaceObjectAtIndex:row withObject:[NSString stringWithFormat:@"%i",end]];
    [self.scoreBoardArray[0] replaceObjectAtIndex:row withObject:@""];
    [self.scoreBoardArray[0] replaceObjectAtIndex:hammerRow withObject:hammerString];
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

- (void)updateDisplay {
    [_yellowScoreLabel setText: [NSString stringWithFormat:@"%i",self.game.yellowScore.totalScore]];
    [_redScoreLabel setText: [NSString stringWithFormat:@"%i",self.game.redScore.totalScore]];
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
