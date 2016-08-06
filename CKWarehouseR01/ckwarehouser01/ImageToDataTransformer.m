//
//  ImageToDataTransformer.m
//  CKWarehouseR01
//
//  Created by Melba Avila on 12/6/15.
//  Copyright (c) 2015 Melba Avila. All rights reserved.
//

#import "ImageToDataTransformer.h"

@implementation ImageToDataTransformer


+ (BOOL)allowsReverseTransformation
{
    return YES;
}


+ (Class)transformedValueClass
{
    return [NSData class];
}


- (id)transformedValue:(id)value
{
    return UIImagePNGRepresentation(value);
}


- (id)reverseTransformedValue:(id)value
{
    return [[UIImage alloc] initWithData:value];
}

@end
