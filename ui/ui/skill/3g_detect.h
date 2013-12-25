//
//  3g_detect.h
//  weaver
//
//  Created by VCTL on 13-12-25.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    NETWORK_TYPE_NONE= 0,
    NETWORK_TYPE_2G,
    NETWORK_TYPE_WIFI,
    NETWORK_TYPE_3G_UNICOM,
    NETWORK_TYPE_3G_TELECOMM,
    NETWORK_TYPE_3G_MOBILE,
}NETWORK_TYPE;

typedef enum {
    INNER_TYPE_NONE= 0,
    INNER_TYPE_2G,
    INNER_TYPE_WIFI,
    INNER_TYPE_3G,
}INNER_TYPE;

@interface net_detect : NSObject

+ (NETWORK_TYPE) detectNetworkType;

+ (INNER_TYPE)dataNetworkTypeFromStatusBar;

@end
