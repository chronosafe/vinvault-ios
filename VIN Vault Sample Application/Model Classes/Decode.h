//
//  Decode.h
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/14/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Vehicle;

@interface Decode : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * vin;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * make;
@property (nonatomic, retain) NSString * series;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSSet *vehicles;
@end

@interface Decode (CoreDataGeneratedAccessors)

- (void)addVehiclesObject:(Vehicle *)value;
- (void)removeVehiclesObject:(Vehicle *)value;
- (void)addVehicles:(NSSet *)values;
- (void)removeVehicles:(NSSet *)values;

@end
