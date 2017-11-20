//
//  NSObject+IFACategory.m
//  IFACoreUI
//
//  Created by Marcelo Schroeder on 28/02/12.
//  Copyright (c) 2012 InfoAccent Pty Limited. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "IFACoreUI.h"

@implementation NSObject (IFACoreUI)

#pragma mark - Public

+ (UIImage *)ifa_classBundleImageNamed:(NSString *)a_imageName {
    return [UIImage imageNamed:a_imageName
                      inBundle:[self ifa_classBundle]
 compatibleWithTraitCollection:nil];
}

- (id)ifa_propertyValueForIndexPath:(NSIndexPath *)anIndexPath inForm:(NSString *)aFormName createMode:(BOOL)aCreateMode{
    //    return [self performSelector:NSSelectorFromString([self propertyNameForIndexPath:anIndexPath inForm:aFormName])];
    return ((id (*)(id, SEL))objc_msgSend)(self, NSSelectorFromString([self ifa_propertyNameForIndexPath:anIndexPath inForm:aFormName
                                                                           createMode:aCreateMode]));
}

- (NSString*)ifa_propertyNameForIndexPath:(NSIndexPath *)anIndexPath inForm:(NSString *)aFormName createMode:(BOOL)aCreateMode{
    return [[IFAPersistenceManager sharedInstance].entityConfig nameForIndexPath:anIndexPath inObject:self inForm:aFormName createMode:aCreateMode];
}

- (NSString*)ifa_propertyStringValueForIndexPath:(NSIndexPath *)anIndexPath inForm:(NSString *)aFormName
                                      createMode:(BOOL)aCreateMode calendar:(NSCalendar*)a_calendar{
    return [self ifa_propertyStringValueForName:[self ifa_propertyNameForIndexPath:anIndexPath inForm:aFormName
                                                                        createMode:aCreateMode]
                                       calendar:a_calendar];
}

@end
