//
//  WebServiceXMLParser.m
//  WebServices
//
//  Created by Di Kong on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import "WebServiceParserDelegate.h"
#import "BeerObject.h"

@interface WebServiceParserDelegate()

@property (nonatomic, readwrite) NSArray *beerList;

@end

@implementation WebServiceParserDelegate

- (instancetype)init {
    
    self = [self initWithData:nil];
    return self;
}

- (instancetype)initWithData:(NSData *)d {
    
    self = [super init];
    
    if (self) {
        self.data = d;
        beerListMutable = [NSMutableArray array];
        verbose = NO;
    }
    
    return self;
}

- (void)startParsing {
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.data];
    [parser setDelegate:self];
    [parser parse];
    parser = nil;
}

#pragma mark - XML Parser Method

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"Beer"]) {
        if (verbose) NSLog(@"%@", currentBeer);
        [beerListMutable addObject:currentBeer];
    }
    else if ([elementName isEqualToString:@"getBeerListResult"]) {
        self.beerList = [NSArray arrayWithArray:beerListMutable];
        if (verbose) NSLog(@"Beer List Updated");
    }
    else if ([elementName isEqualToString:@"getBeerListResponse"]);
    else if ([elementName isEqualToString:@"soap:Body"]);
    else if ([elementName isEqualToString:@"soap:Envelope"]);
    else {
        [currentBeer setValue:currentElement forKey:elementName];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"Beer"])
        currentBeer = [[BeerObject alloc] init];
    else
        currentElement = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    [currentElement appendString:string];
}

@end
