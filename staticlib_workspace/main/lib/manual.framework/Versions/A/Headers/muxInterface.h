//
//  muxInterface.h
//  abcUniManual
//
//  Created by VCTL on 13-12-24.
//  Copyright (c) 2013年 self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface muxInterface : NSObject

@end

#ifdef __cplusplus
extern "C" {
#endif
    
    void manual_say_mux_c();
    void manual_say_mux_oc();

#ifdef __cplusplus
}
#endif
