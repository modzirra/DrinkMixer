//
//  Drink.h
//  DrinkMixer
//
//  Created by Aimee on 12/14/13.
//  Copyright (c) 2013 Web Diggity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Drink : NSObject

@property (nonatomic, strong) IBOutlet NSString *ingredientsTextView;
@property (nonatomic, strong) IBOutlet NSString *directionsTextView;
@property (nonatomic, strong) IBOutlet NSString *nameTextField;

@end
