//
//  CategoryTableViewController.m
//  WebServices
//
//  Created by Di Kong on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "BeerTableViewController.h"
#import "WebServiceConnectionDelegate.h"
#import "WebServiceParserDelegate.h"
#import "BeerObject.h"

@implementation CategoryTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.spinner startAnimating];
    self.spinner.hidesWhenStopped = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.spinner];
    
    WebServiceConnectionDelegate *webSvcCon = [[WebServiceConnectionDelegate alloc]
                                               initWithUrl:@"http://www.softwaremerchant.com/onlinecourse.asmx"
                                               method:@"getBeerList"];
    
    [webSvcCon setSignalDelegate:self];
    [webSvcCon establishConnection];
}


#pragma mark - Connection Did Finish Signal

- (void)signalFrom:(id)sender {
    
    __block NSMutableArray *beerCategoryListMutable = [NSMutableArray array];
    __block NSMutableDictionary *beerCategoryDictMutable = [NSMutableDictionary dictionary];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^(void) {
        
        dispatch_group_t group = dispatch_group_create();
        
        dispatch_group_async(group, queue, ^{
            
            WebServiceConnectionDelegate *webSvcCon = (WebServiceConnectionDelegate *)sender;
            WebServiceParserDelegate *xmlParser = [[WebServiceParserDelegate alloc] initWithData:webSvcCon.responseData];
            [xmlParser startParsing];
            
            beerList = xmlParser.beerList;
            for (int i = 0; i < beerList.count; i ++) {
                BeerObject *beer = beerList[i];
                NSString *category = beer.beer_category_name;
                if (![beerCategoryListMutable containsObject:category]) {
                    [beerCategoryListMutable addObject:category];
                    NSMutableArray *beerInSameCategory = [NSMutableArray arrayWithObject:beer];
                    for (int j = i + 1; j < beerList.count; j ++) {
                        BeerObject *anotherBeer = beerList[j];
                        if ([anotherBeer.beer_category_name isEqualToString:category]) {
                            [beerInSameCategory addObject:anotherBeer];
                        }
                    }
                    [beerCategoryDictMutable setObject:beerInSameCategory forKey:category];
                }
            }

        });
        
        dispatch_group_notify(group, queue, ^{
            
            beerCategoryList = [NSArray arrayWithArray:beerCategoryListMutable];
            beerCategoryDict = [NSDictionary dictionaryWithDictionary:beerCategoryDictMutable];
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                
                [self.spinner stopAnimating];
                [self.tableView reloadData];
            });
        });
    });
    
}


#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return beerCategoryList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = beerCategoryList[indexPath.row];;
    
    return cell;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSString *selectedCategory = beerCategoryList[indexPath.row];
    BeerTableViewController *dest = (BeerTableViewController *)[segue destinationViewController];
    [dest setBeerListInCategory:beerCategoryDict[selectedCategory]];
}


@end
