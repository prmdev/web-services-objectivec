//
//  BeerObject.m
//  WebServices
//
//  Created by Di Kong on 2/4/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import "BeerObject.h"

@interface BeerObject()

@property (nonatomic, readwrite) float beer_ABV_value;
@property (nonatomic, readwrite) float beer_size_value;
@property (nonatomic, readwrite) float beer_price_value;

@end

@implementation BeerObject

- (instancetype)init {
    self = [self initWithName:@"Sample Beer"
                     location:@""
                          abv:@""
                         size:@""
                        price:@""
                  description:@""
                     category:@"Default"
                         date:@""];
    return self;
}

- (instancetype)initWithName:(NSString *)n
                    location:(NSString *)l
                         abv:(NSString *)a
                        size:(NSString *)s
                       price:(NSString *)p
                 description:(NSString *)ds
                    category:(NSString *)c
                        date:(NSString *)dt
{
    self = [super init];
    
    if (self) {
        self.beer_name = n;
        self.beer_location = l;
        self.beer_ABV = a;
        self.beer_size = s;
        self.beer_price = p;
        self.beer_description = ds;
        self.beer_category_name = c;
        self.beer_date_added = dt;
        [self parseABV];
        [self parseSize];
        [self parsePrice];
    }
    
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKeyPath:key];
    if ([key isEqualToString:@"beer_ABV"])
        [self parseABV];
}

- (void)parseABV {
    NSArray *abvArray = [self.beer_ABV componentsSeparatedByString:@" "];
    if ([abvArray count] > 1)
        self.beer_ABV_value = [abvArray[1] floatValue];
}

- (void)parseSize {
    self.beer_size_value = [self.beer_size floatValue];
}

- (void)parsePrice {
    
    self.beer_price_value = [self.beer_price floatValue];
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"\n========== Beer Info ==========\n"
            "Beer Name: %@\n"
            "Beer Loacation: %@\n"
            "Beer ABV: %f\n"
            "Beer Size: %f\n"
            "Beer Price: %f\n"
            "Beer Description: %@\n"
            "Beer Category Name: %@\n"
            "Beer Date Added: %@\n\n",
            self.beer_name, self.beer_location, self.beer_ABV_value, self.beer_size_value,
            self.beer_price_value, self.beer_description, self.beer_category_name, self.beer_date_added];
}

@end
