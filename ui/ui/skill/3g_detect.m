//
//  3g_detect.m
//  weaver
//
//  Created by VCTL on 13-12-25.
//
//

#import "3g_detect.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation net_detect

+ (NETWORK_TYPE) detectNetworkType {
    INNER_TYPE inner_type = [net_detect dataNetworkTypeFromStatusBar];
    NSLog(@"erik net: inner type is %d", inner_type);
    switch (inner_type) {
        case INNER_TYPE_NONE:
            return NETWORK_TYPE_NONE;
            break;
        case INNER_TYPE_WIFI:
        default:
            return NETWORK_TYPE_WIFI;
            break;
        case INNER_TYPE_2G:
            return NETWORK_TYPE_2G;
            break;
        case INNER_TYPE_3G:
            break;
    }
    CTCarrier *cInfoEx = [[[CTTelephonyNetworkInfo alloc] init] subscriberCellularProvider];
    NSString *strInfo = [cInfoEx description];
    NSLog(@"erik net:%@", strInfo);
    // unicom ----------------------------------------
    NSRange found = [strInfo rangeOfString:@"中国联通"];
    if (found.location != NSNotFound) {
        NSLog(@"erik net:中国联通");
        return NETWORK_TYPE_3G_UNICOM;
    }
    found = [strInfo rangeOfString:@"ChinaUnicom"];
    if (found.location != NSNotFound) {
        NSLog(@"erik net:中国联通");
        return NETWORK_TYPE_3G_UNICOM;
    }
    // telecom ----------------------------------------
    found = [strInfo rangeOfString:@"中国电信"];
    if (found.location != NSNotFound) {
        NSLog(@"erik net:中国电信");
        return NETWORK_TYPE_3G_TELECOMM;
    }
    found = [strInfo rangeOfString:@"ChinaTelecom"];
    if (found.location != NSNotFound) {
        NSLog(@"erik net:中国电信");
        return NETWORK_TYPE_3G_TELECOMM;
    }
    // mobile ----------------------------------------
    found = [strInfo rangeOfString:@"中国移动"];
    if (found.location != NSNotFound) {
        NSLog(@"erik net:中国移动");
        return NETWORK_TYPE_3G_MOBILE;
    }
    found = [strInfo rangeOfString:@"ChinaMobile"];
    if (found.location != NSNotFound) {
        NSLog(@"erik net:中国移动");
        return NETWORK_TYPE_3G_MOBILE;
    }
    

    NSLog(@"erik net:中国联通（默认）");
    return NETWORK_TYPE_3G_UNICOM;
}

+ (INNER_TYPE)dataNetworkTypeFromStatusBar {
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    int netType = INNER_TYPE_NONE;
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    if (num == nil) {
        
        netType = NETWORK_TYPE_NONE;
        
    }else{
        
        int n = [num intValue];
        if (n == 0) {
            netType = INNER_TYPE_NONE;
        }else if (n == 1){
            netType = INNER_TYPE_2G;
        }else if (n == 2){
            netType = INNER_TYPE_3G;
        }else{
            netType = NETWORK_TYPE_WIFI;
        }
        
    }
    
    return netType;
}

@end

