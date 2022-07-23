//
//  BeerDetailViewController.m
//  WebServices
//
//  Created by prmdev on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import "BeerDetailViewController.h"

@implementation BeerDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.beerDetailTextView.text = [NSString stringWithFormat:@"%@", self.beer];
}



@end
