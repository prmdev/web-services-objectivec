//
//  WebServiceXMLParser.h
//  WebServices
//
//  Created by prmdev on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BeerObject;

@interface WebServiceParserDelegate : NSObject <NSXMLParserDelegate> {

    NSMutableString *currentElement;
    NSMutableArray *beerListMutable;
    BeerObject *currentBeer;
    BOOL verbose;
}

@property (nonatomic, strong)   NSData *data;
@property (nonatomic, readonly) NSArray *beerList;

- (instancetype)init;
- (instancetype)initWithData:(NSData *)d;
- (void)startParsing;

@end
