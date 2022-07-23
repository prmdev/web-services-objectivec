//
//  ViewController.h
//  WebServicesLogin
//
//  Created by prmdev on 2/3/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController
<NSXMLParserDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)loginPressed:(id)sender;

@end

