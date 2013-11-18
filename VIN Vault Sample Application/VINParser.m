//
//  VINParser.m
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/14/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import "VINParser.h"
#import "Decode.h"
#import "Vehicle.h"
#import "Item.h"
#import "ItemOption.h"
#import "Constants.h"

@implementation VINParser

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    
    return _sharedManager;
}


// Take a JSON string and parse it into individual managed objects that we can persist
-(void)parseData:(NSString *)JSONData context:(NSManagedObjectContext *)context
  withCompletion:(void (^)(BOOL success))completion {
    NSError *error;
    id JSONObject = [NSJSONSerialization
                     JSONObjectWithData:[JSONData dataUsingEncoding:NSUTF8StringEncoding]
                     options:NSJSONReadingAllowFragments
                     error:&error];
    NSDictionary *dict = JSONObject;
    NSDictionary *root = [dict objectForKey:@"decode"];
    // We have the root decode, let's create a decode object
    Decode *decode = nil;
    // Determine if the VIN was successfully decoded
    NSString *status = root[@"status"][0];
    if ([status isEqualToString:@"true"]) {
        
        // Create the decode object
        decode = [NSEntityDescription insertNewObjectForEntityForName:@"Decode"
                                               inManagedObjectContext:context];
        
        // Extract the data from the root to create the Decode object
        decode.vin = root[@"vin"];
        decode.date = [NSDate date];
        decode.make = root[@"make"];
        decode.series = root[@"series"];
        decode.year = root[@"year"];
        decode.status = status;
        id vehicles = root[@"trim"]; // At this point we're not sure if the data is a dictionary or an array
        if (vehicles != nil) {
            decode.vehicles = [self parseVehicles:vehicles context: context];
        }
        
    } else {
        // Unsuccessful decode
        // return false in the completion block
        completion(NO);
    }
    
    // If there's a completion block respond with a true value for 'success'
    if (completion) {
        completion(YES);
    }

}

// Parse the data to extract the vehicles
// The data is returned as a set
-(NSSet *)parseVehicles: (id)data context: (NSManagedObjectContext *) context {
    
    NSMutableSet *set = [[NSMutableSet alloc] init];
    // Use introspection to determine if it's a collection of vehicles or just a single one
    if ([data isKindOfClass:[NSArray class]]) {
        // If it's an array then we need to loop through the elements and process them
        for (NSDictionary *trim in data) {
            Vehicle *vehicle = [self createVehicleFromDictionary:trim context:context];
            [set addObject:vehicle];
        }
    } else {
        if ([data isKindOfClass:[NSDictionary class]]) {
            // Since it's a dictionary then it's only a single vehicle
            Vehicle *vehicle = [self createVehicleFromDictionary:data context:context];
            [set addObject:vehicle];
        }
    }
    return set; // Return the set of processed vehicles
}

// Return a newly created Vehicle object based on JSON
// This will recursively parse the JSON to extract all of the sub objects as well
-(Vehicle *)createVehicleFromDictionary:(NSDictionary *)dict context:(NSManagedObjectContext *)context {
    Vehicle *vehicle = [NSEntityDescription insertNewObjectForEntityForName:@"Vehicle"
                                                     inManagedObjectContext:context];
    // Extract the data for the vehicle
    vehicle.trim = dict[@"name"];
    id items = dict[@"data"];
    if (items != nil) {
        vehicle.items = [self parseItems:items context:context];
    }
    return vehicle;
}

// We need to parse the items from the JSON.  It might be an array (most likely) but potentially a single object
-(NSSet *)parseItems:(id)data context:(NSManagedObjectContext *) context {
    NSMutableSet *set = [[NSMutableSet alloc] init];
    // Use introspection to determine if it's a collection of items or just a single one
    if ([data isKindOfClass:[NSArray class]]) {
        // If it's an array then we need to loop through the elements and process them
        for (NSDictionary *item in data) {
            Item *parsedItem = [self createItemFromDictionary:item context:context];
            [set addObject: parsedItem];
        }
    } else {
        if ([data isKindOfClass:[NSDictionary class]]) {
            // Since it's a dictionary then it's only a single data item
            Item *item = [self createItemFromDictionary:data context:context];
            [set addObject:item];
        }
    }
    return set; // Return the set of processed items
}

// We need to extract the item from the dictionary provided by the JSON
-(Item *)createItemFromDictionary:(NSDictionary *)dict context:(NSManagedObjectContext *)context {
    // Create the managed object
    Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item"
                                                     inManagedObjectContext:context];
    
    // Extract the data for the Item
    item.category = dict[@"category"];
    item.value = dict[@"value"];
    item.unit = dict[@"unit"];
    item.group = dict[@"group"];
    
    // If the item has any optional values then we need to create these values as well and add them to the options set
    id options = dict[@"option"];
    if (options != nil) {
        item.options = [self parseItemOptions:options context:context];
    }
    return item;
}

// Parse JSON to get a set of ItemOption values
-(NSSet *)parseItemOptions:(id)data context:(NSManagedObjectContext *)context {
    NSMutableSet *set = [[NSMutableSet alloc] init];
    // Use introspection to determine if it's a collection of options or just a single one
    if ([data isKindOfClass:[NSArray class]]) {
        // If it's an array then we need to loop through the elements and process them
        for (NSDictionary *option in data) {
            ItemOption *parsedOption = [self createItemOptionFromString:option context:context];
            [set addObject: parsedOption];
        }
    } else {
        if ([data isKindOfClass:[NSDictionary class]]) {
            // Since it's a dictionary then it's only a single item option
            ItemOption *option = [self createItemOptionFromString:data context:context];
            [set addObject:option];
        }
    }
    return set; // Return the set of processed items
}

// Create an ItemOption from a dictionary of JSON data
-(ItemOption *)createItemOptionFromString:(NSDictionary *)data context:(NSManagedObjectContext *)context {
    // Create the managed object
    ItemOption *option = [NSEntityDescription insertNewObjectForEntityForName:@"ItemOption"
                                               inManagedObjectContext:context];
    
    // Extract the data for the Item
    option.value = data[@"value"];
    return option;
}

@end
