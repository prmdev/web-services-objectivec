//
//  BeerDetailViewController.h
//  WebServices
//
//  Created by prmdev on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeerObject.h"

@interface BeerDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *beerDetailTextView;
@property (nonatomic, strong) BeerObject *beer;

@end
