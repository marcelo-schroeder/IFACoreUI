//
//  IFAEntityConfig+IFACoreUI.m
//  IFACoreUI
//
//  Created by Marcelo Schroeder on 21/11/17.
//  Copyright © 2017 InfoAccent Pty Ltd. All rights reserved.
//

#import "IFAEntityConfig+IFACoreUI.h"

@implementation IFAEntityConfig (IFACoreUI)

- (id) fieldForIndexPath:(NSIndexPath *)anIndexPath inObject:(NSObject *)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode{
    return [[[self formSectionsForObject:anObject inForm:aFormName
                              createMode:aCreateMode][(NSUInteger) anIndexPath.section] objectForKey:@"fields"] objectAtIndex:(NSUInteger) anIndexPath.row];
}

- (NSString*)fieldTypePListValueForIndexPath:(NSIndexPath *)anIndexPath inObject:(NSObject *)anObject
                                      inForm:(NSString *)aFormName
                                  createMode:(BOOL)aCreateMode{
    return [[self fieldForIndexPath:anIndexPath inObject:anObject inForm:aFormName createMode:aCreateMode] valueForKey:@"type"];
}

- (NSIndexPath*)indexPathForProperty:(NSString*)aPropertyName inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode{
    NSArray *l_sections = [self formSectionsForObject:anObject inForm:aFormName createMode:aCreateMode];
    NSUInteger l_section = 0;
    for (NSDictionary *l_sectionDict in l_sections) {
        NSArray *l_fields = l_sectionDict[@"fields"];
        NSUInteger l_row = 0;
        for (NSDictionary *l_fieldDict in l_fields) {
            if ([l_fieldDict[@"name"] isEqualToString:aPropertyName]) {
                return [NSIndexPath indexPathForRow:l_row inSection:l_section];
            }
            l_row++;
        }
        l_section++;
    }
    return nil;
}

- (NSString *)footerForSectionIndex:(NSInteger)a_sectionIndex
                           inObject:(NSObject *)a_object
                             inForm:(NSString *)a_formName
                         createMode:(BOOL)a_createMode {
    NSDictionary *formSection = [self formSectionDictionaryAtIndex:a_sectionIndex
                                                          inObject:a_object
                                                       inFormNamed:a_formName
                                                        createMode:a_createMode];
    NSString *help = nil;
    NSUInteger fieldCount = [self fieldCountCountForSectionIndex:a_sectionIndex
                                                        inObject:a_object
                                                          inForm:a_formName
                                                      createMode:a_createMode];
    // If there is only one field in the section, then check if there is help available specifically for that field's property
    if (fieldCount == 1) {
        NSIndexPath *fieldIndexPath = [NSIndexPath indexPathForRow:0
                                                         inSection:a_sectionIndex];
        NSDictionary *field = [self fieldForIndexPath:fieldIndexPath
                                             inObject:a_object
                                               inForm:a_formName
                                           createMode:a_createMode];
        NSString *propertyHelpValue = nil;
        NSString *propertyName = field[@"name"];
        // Try to obtain help for the property from a custom property
        NSString *helpPropertyName = [self helpPropertyNameForProperty:propertyName
                                                              inObject:a_object];
        if (helpPropertyName) {
            help = [a_object valueForKey:helpPropertyName];
        }
        // If there is no help for the property from a custom property, then try the normal channels
        if (!help) {
            IFAEntityConfigFieldType fieldType = [self fieldTypeForIndexPath:fieldIndexPath
                                                                    inObject:a_object
                                                                      inForm:a_formName
                                                                  createMode:a_createMode];
            if (fieldType == IFAEntityConfigFieldTypeProperty) {
                id propertyValue = [a_object valueForKey:propertyName];
                if ([propertyValue isKindOfClass:[NSNumber class]]) {
                    NSNumber *number = propertyValue;
                    propertyHelpValue = number.stringValue;
                } else if ([propertyValue isKindOfClass:[IFASystemEntity class]]) {
                    IFASystemEntity *systemEntity = propertyValue;
                    propertyHelpValue = systemEntity.systemEntityId.stringValue;
                }
                help = [[IFAHelpManager sharedInstance] helpForPropertyName:propertyName
                                                               inEntityName:a_object.ifa_entityName
                                                                      value:propertyHelpValue];
            }
            // If there is no help for a specific property value, try help for the property itself
            if (!help) {
                help = [[IFAHelpManager sharedInstance] helpForPropertyName:propertyName
                                                               inEntityName:a_object.ifa_entityName
                                                                      value:nil];
            }
        }
    }
    // If there is no help available yet, try to get help for the section
    if (!help) {
        // Try to obtain help for the section from a custom property
        NSString *helpPropertyName = formSection[@"helpPropertyName"];
        if (helpPropertyName) {
            help = [a_object valueForKey:helpPropertyName];
        }
        // If there is no help for the section from a custom property, then try the normal channels
        if (!help) {
            help = [[IFAHelpManager sharedInstance] helpForSectionNamed:formSection[@"name"]
                                                            inFormNamed:a_formName
                                                             createMode:a_createMode
                                                            entityNamed:a_object.ifa_entityName];
        }

    }
    if (help) {
        return help;
    } else {
        NSString *key = [NSString stringWithFormat:@"entities.%@.forms.%@.sections.%@.sectionFooter",
                                                   [a_object.class ifa_entityName],
                                                   a_formName,
                                                   formSection[@"name"]];
        NSString *string = [self localisedStringForKey:key];
        if ([string isEqualToString:key]) {
            return formSection[@"sectionFooter"];
        } else {
            return string;
        }
    }
}

- (NSString*)labelForIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject *)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode{
    NSString *fieldName = [self nameForIndexPath:anIndexPath inObject:anObject inForm:aFormName createMode:aCreateMode];
    BOOL l_isFormFieldType = [self fieldTypeForIndexPath:anIndexPath inObject:anObject inForm:aFormName createMode:aCreateMode]==IFAEntityConfigFieldTypeForm;
    if (l_isFormFieldType) {
        return [self labelForForm:fieldName inObject:anObject];
    }else {    // it's a property
        return [self labelForProperty:fieldName inObject:anObject];
    }
}

- (NSString*)nameForIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode{
    return [[self fieldForIndexPath:anIndexPath inObject:anObject inForm:aFormName createMode:aCreateMode] valueForKey:@"name"];
}

- (NSString*)labelForViewControllerFieldTypeAtIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode{
    return [[self fieldForIndexPath:anIndexPath inObject:anObject inForm:aFormName createMode:aCreateMode] valueForKey:@"label"];
}

- (BOOL)isModalForViewControllerFieldTypeAtIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode{
    return [[[self fieldForIndexPath:anIndexPath inObject:anObject inForm:aFormName createMode:aCreateMode] valueForKey:@"isModalViewController"] boolValue];
}

- (NSString*)classNameForViewControllerFieldTypeAtIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode{
    return [[self fieldForIndexPath:anIndexPath inObject:anObject inForm:aFormName createMode:aCreateMode] valueForKey:@"viewController"];
}

- (NSDictionary*)propertiesForViewControllerFieldTypeAtIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode{
    return [[self fieldForIndexPath:anIndexPath inObject:anObject inForm:aFormName createMode:aCreateMode] valueForKey:@"viewControllerProperties"];
}

- (BOOL)isReadOnlyForIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode{
    return [[[self fieldForIndexPath:anIndexPath inObject:anObject inForm:aFormName createMode:aCreateMode] valueForKey:@"readOnly"] boolValue];
}

- (NSString*)urlPropertyNameForIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode{
    return [[self fieldForIndexPath:anIndexPath inObject:anObject inForm:aFormName createMode:aCreateMode] valueForKey:@"urlProperty"];
}

- (IFAEntityConfigFieldType)fieldTypeForIndexPath:(NSIndexPath *)a_indexPath inObject:(NSObject *)a_object
                                                                               inForm:(NSString *)a_formName
                                       createMode:(BOOL)a_createMode {
    IFAEntityConfigFieldType l_fieldType = IFAEntityConfigFieldTypeProperty;
    NSString *l_pListValue = [self fieldTypePListValueForIndexPath:a_indexPath
                                                          inObject:a_object
                                                            inForm:a_formName
                                                        createMode:a_createMode];
    if ([l_pListValue isEqualToString:@"property"]) {
        l_fieldType = IFAEntityConfigFieldTypeProperty;
    }else if ([l_pListValue isEqualToString:@"form"]) {
        l_fieldType = IFAEntityConfigFieldTypeForm;
    }else if ([l_pListValue isEqualToString:@"viewController"]) {
        l_fieldType = IFAEntityConfigFieldTypeViewController;
    }else if ([l_pListValue isEqualToString:@"button"]) {
        l_fieldType = IFAEntityConfigFieldTypeButton;
    }else if ([l_pListValue isEqualToString:@"custom"]) {
        l_fieldType = IFAEntityConfigFieldTypeCustom;
    }else{
        NSAssert(NO, @"Unexpected field type plist value: %@", l_pListValue);
    }
    return l_fieldType;
}

- (BOOL)isDestructiveButtonAtIndexPath:(NSIndexPath *)a_indexPath
                              inObject:(NSObject *)a_object
                                inForm:(NSString *)a_formName
                            createMode:(BOOL)a_createMode {
    return ((NSNumber *) [[self fieldForIndexPath:a_indexPath inObject:a_object inForm:a_formName
                                       createMode:a_createMode] valueForKey:@"destructive"]).boolValue;
}

@end
