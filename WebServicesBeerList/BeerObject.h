//
//  BeerObject.h
//  WebServices
//
//  Created by Di Kong on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeerObject : NSObject

@property (nonatomic, copy)  NSString *beer_name;
@property (nonatomic, copy)  NSString *beer_location;
@property (nonatomic, copy)  NSString *beer_ABV;
@property (nonatomic, readonly) float beer_ABV_value;
@property (nonatomic, copy)  NSString *beer_size;
@property (nonatomic, readonly) float beer_size_value;
@property (nonatomic, copy)  NSString *beer_price;
@property (nonatomic, readonly) float beer_price_value;
@property (nonatomic, copy)  NSString *beer_description;
@property (nonatomic, copy)  NSString *beer_category_name;
@property (nonatomic, copy)  NSString *beer_date_added;


- (instancetype)init;
- (instancetype)initWithName:(NSString *)n
                    location:(NSString *)l
                         abv:(NSString *)a
                        size:(NSString *)s
                       price:(NSString *)p
                 description:(NSString *)ds
                    category:(NSString *)c
                        date:(NSString *)dt;
- (void)parseABV;
- (void)parseSize;
- (void)parsePrice;

@end
