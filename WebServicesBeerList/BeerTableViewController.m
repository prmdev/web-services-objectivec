//
//  BeerTableViewController.m
//  WebServices
//
//  Created by Di Kong on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import "BeerTableViewController.h"
#import "BeerDetailViewController.h"
#import "BeerObject.h"

@implementation BeerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView reloadData];
}


#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.beerListInCategory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    BeerObject *b = self.beerListInCategory[indexPath.row];
    cell.textLabel.text = b.beer_name;
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    BeerObject *beer = self.beerListInCategory[indexPath.row];
    BeerDetailViewController *dest = (BeerDetailViewController *)[segue destinationViewController];
    [dest setBeer:beer];
}


@end
