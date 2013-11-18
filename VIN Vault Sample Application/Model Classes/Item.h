//
//  Item.h
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/14/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ItemOption, Vehicle;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSString * group;
@property (nonatomic, retain) NSSet *options;
@property (nonatomic, retain) Vehicle *vehicle;
@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addOptionsObject:(ItemOption *)value;
- (void)removeOptionsObject:(ItemOption *)value;
- (void)addOptions:(NSSet *)values;
- (void)removeOptions:(NSSet *)values;

@end
