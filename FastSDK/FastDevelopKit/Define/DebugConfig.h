//
//  DebugConfig.h
//  FastDevelopKit
//
//  Created by zhao on 2/2/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#ifndef DebugConfig_h
#define DebugConfig_h

/** Log */
#ifndef DLog
#if DEBUG
#define DLog(id, ...) NSLog((@"%s Line %d: " id),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(id, ...)
#endif
#endif

/** exception */
#define $Try    @try {

#define $Catch    }\
@catch (NSException *exception) {\
NSString *exceptionInfo = [NSString stringWithFormat:@"exception = %@\n Class = %@\n SEL = %@\n ",exception,self,NSStringFromSelector(_cmd)];\
DLog(@"%@",exceptionInfo);\
}

#endif /* DebugConfig_h */
