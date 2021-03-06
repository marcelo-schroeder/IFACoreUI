//
// Created by Marcelo Schroeder on 8/09/2014.
// Copyright (c) 2014 InfoAccent Pty Ltd. All rights reserved.
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

#import <Foundation/Foundation.h>
#import "IFAViewController.h"
#import "IFALocationManager.h"
#import <MapKit/MapKit.h>

@class MKMapView;
@protocol IFAMapViewControllerDelegate;

/**
* This class encapsulates functionality and data normally required when implementing a view controller that displays a map.
* Once the view has loaded, an instance of this class also becomes the delegate for mapView.
*/
@interface IFAMapViewController : IFAViewController <MKMapViewDelegate>

/**
* Map view controller delegate.
*/
@property (nonatomic, weak) id<IFAMapViewControllerDelegate> mapViewControllerDelegate;

/**
* Bar button used to center the user's location on the map.
*/
@property(nonatomic, strong, readonly) UIBarButtonItem *userLocationBarButtonItem;

/**
* Bar button used to show the map settings view.
*/
@property(nonatomic, strong, readonly) UIBarButtonItem *mapSettingsBarButtonItem;

/**
* Map view instance. Must be instantiated either by Interface Builder or programmatically.
*/
@property (nonatomic, strong) IBOutlet MKMapView *mapView;

/**
* Determines the authorisation type to be requested before the user location can be shown on the map.
* Default: IFALocationAuthorizationTypeWhenInUse.
*/
@property (nonatomic) IFALocationAuthorizationType locationAuthorizationType;

/**
* Prevents automatic user location requests when not authorised at various points of the view controller life cycle such as: on viewDidAppear, on app becoming active after being suspended and when location services authorisation status has changed.
* Default: NO.
*/
@property (nonatomic) BOOL preventsLocatingUserAutomaticallyIfNotAuthorised;

/**
* Locates user on the map.
* @param a_completionBlock Block to execute when the user location is known. The block receives a BOOL parameter indicating whether the operation has succeeded.
* @param a_userInitiated Set to YES to indicate that the user location request was initiated by the user, otherwise set it to NO (i.e. for automatic user location requests such as on viewDidAppear).
*/
- (void)locateUserDueToUserRequest:(BOOL)a_userInitiated
                   completionBlock:(void (^)(BOOL a_success))a_completionBlock;
@end

@protocol IFAMapViewControllerDelegate <NSObject>

@optional

/**
* Called after the initial user location request has been completed.
* This method is called only once in the lifetime of a_mapViewController.
* @param a_mapViewController Sender.
* @param a_success Indicates whether the user location request has been successful or not.
*/
- (void)mapViewController:(IFAMapViewController *)a_mapViewController didCompleteInitialUserLocationRequestWithSuccess:(BOOL)a_success;

/**
* Called after showing the current location as a result of the user tapping the current location button.
* @param a_mapViewController Sender.
*/
- (void)mapViewControllerDidCompleteUserRequestToShowCurrentLocation:(IFAMapViewController *)a_mapViewController;

@end
