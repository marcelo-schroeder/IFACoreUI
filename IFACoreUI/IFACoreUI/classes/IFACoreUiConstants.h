//
//  IFACoreUiConstants.h
//  IFACoreUI
//
//  Created by Marcelo Schroeder on 24/06/10.
//  Copyright 2010 InfoAccent Pty Limited. All rights reserved.
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

@interface IFACoreUiConstants : NSObject {

}

extern CGFloat const IFAMinimumTapAreaDimension;

/**
* Table view cell horizontal indentation in points when in edit mode.
*/
extern CGFloat const IFATableViewEditingCellXOffset;

extern CGFloat const IFAFormSectionHeaderDefaultHeight;
extern CGFloat const IFATableViewCellSeparatorDefaultInsetLeft;
extern CGFloat const IFAIPhoneStatusBarDoubleHeight;
extern NSTimeInterval const IFAAnimationDuration;

extern NSString* const IFACacheKeyMenuViewControllersDictionary;

// Notifications
extern NSString* const IFANotificationContextSwitchRequest;
extern NSString* const IFANotificationContextSwitchRequestGranted;
extern NSString* const IFANotificationContextSwitchRequestDenied;
extern NSString* const IFANotificationMenuBarButtonItemInvalidated;
extern NSString* const IFANotificationLocationAuthorizationStatusChange;

/* enums */

enum {

    IFAViewTagActionSheetCancel = 2000,
    IFAViewTagActionSheetDelete = 2010,
    IFAViewTagHelpBackground = 2020,
    IFAViewTagHelpForeground = 2030,
    IFAViewTagHelpButton = 2050,

    IFABarItemTagHelpButton = 2500,
    IFABarItemTagEditButton = 2510,
    IFABarItemTagBackButton = 2520, // custom back button
    IFABarItemTagLeftSlidingPaneButton = 2530, // split view controller master on iPad, left under view on iPhone
    IFABarItemTagAutomatedSpacingButton = 2540, // bar button item spacing automation

};

/* typedefs */

typedef NS_ENUM(NSUInteger, IFABarButtonItemType){
    IFABarButtonItemTypeAdd,
    IFABarButtonItemTypeDelete,
    IFABarButtonItemTypeSelectNone,
    IFABarButtonItemTypeCancel,
    IFABarButtonItemTypeFlexibleSpace,
    IFABarButtonItemTypeDone,
    IFABarButtonItemTypePreviousPage,
    IFABarButtonItemTypeNextPage,
    IFABarButtonItemTypeSelectNow,
    IFABarButtonItemTypeFixedSpace,
    IFABarButtonItemTypeSelectAll,
    IFABarButtonItemTypeAction,
    IFABarButtonItemTypeSelectToday,
    IFABarButtonItemTypeRefresh,
    IFABarButtonItemTypeDismiss,
    IFABarButtonItemTypeBack,
    IFABarButtonItemTypeInfo,
    IFABarButtonItemTypeUserLocation,
    IFABarButtonItemTypeList,
};

@end
