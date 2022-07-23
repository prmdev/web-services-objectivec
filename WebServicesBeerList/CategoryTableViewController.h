//
//  CategoryTableViewController.h
//  WebServices
//
//  Created by prmdev on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionDidFinishSignal.h"

@interface CategoryTableViewController : UITableViewController <ConnectionDidFinishSignal> {

    NSArray *beerList;
    NSArray *beerCategoryList;
    NSDictionary *beerCategoryDict;
}

@property (nonatomic, strong) UIActivityIndicatorView *spinner;


@end
