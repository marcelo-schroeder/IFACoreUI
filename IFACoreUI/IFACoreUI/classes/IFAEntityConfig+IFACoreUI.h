//
//  IFAEntityConfig+IFACoreUI.h
//  IFACoreUI
//
//  Created by Marcelo Schroeder on 21/11/17.
//  Copyright © 2017 InfoAccent Pty Ltd. All rights reserved.
//

#import <IFACoreData/IFACoreData.h>

@interface IFAEntityConfig (IFACoreUI)

- (NSIndexPath*)indexPathForProperty:(NSString*)aPropertyName inObject:(NSObject*)aObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode;
- (NSString*)labelForViewControllerFieldTypeAtIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode;
- (BOOL)isModalForViewControllerFieldTypeAtIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode;
- (NSString*)classNameForViewControllerFieldTypeAtIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode;
- (NSDictionary*)propertiesForViewControllerFieldTypeAtIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode;
- (BOOL)isReadOnlyForIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode;
- (NSString*)urlPropertyNameForIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode;
- (NSString *)footerForSectionIndex:(NSInteger)a_sectionIndex inObject:(NSObject *)a_object inForm:(NSString *)a_formName
                                                                                        createMode:(BOOL)a_createMode;

- (NSString*)labelForIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode;
- (NSString*)nameForIndexPath:(NSIndexPath*)anIndexPath inObject:(NSObject*)anObject inForm:(NSString*)aFormName createMode:(BOOL)aCreateMode;
- (IFAEntityConfigFieldType)fieldTypeForIndexPath:(NSIndexPath *)a_indexPath inObject:(NSObject *)a_object
                                           inForm:(NSString *)a_formName createMode:(BOOL)a_createMode;

- (BOOL)isDestructiveButtonAtIndexPath:(NSIndexPath *)a_indexPath inObject:(NSObject *)a_object
                                inForm:(NSString *)a_formName createMode:(BOOL)a_createMode;

@end
