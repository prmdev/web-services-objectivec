//
//  BeerTableViewController.h
//  WebServices
//
//  Created by prmdev on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeerTableViewController : UITableViewController

@property (nonatomic, copy)   NSString *category;
@property (nonatomic, strong) NSArray *beerListInCategory;

@end
