//
//  CategoryTableViewController.m
//  WebServices
//
//  Created by Di Kong on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "WebServiceConnectionDelegate.h"
#import "WebServiceParserDelegate.h"

@implementation CategoryTableViewController

- (void)viewWillAppear:(BOOL)animated {
    
    WebServiceConnectionDelegate *webSvcCon = [[WebServiceConnectionDelegate alloc]
                                              initWithUrl:@"http://www.softwaremerchant.com/onlinecourse.asmx"
                                              method:@"getBeerList"];
    
    [webSvcCon establishConnection];

    
    /*[self callParser:webSvcCon.responseData];*/
    /*NSData *data = webSvcCon.responseData;*/
    /*else {
     NSLog(@"webSvcCon returned !connectionDidFinish");
     [[[UIAlertView alloc] initWithTitle:@"Cannot load web service"
     message:@"Please check your internet connection."
     delegate:nil
     cancelButtonTitle:@"All right"
     otherButtonTitles:nil]
     show];
     }*/

}

/*- (void)callParser:(NSData *)data {
    WebServiceParserDelegate *parser = [[WebServiceParserDelegate alloc] initWithData:data];
    [parser startParsing];
}*/

@end
