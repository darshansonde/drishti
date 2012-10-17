// basic defines for DKit


//should become a code snippet
#define DCallToPhoneNumber(x) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:x]]
#define DCallToPhoneNumberCheck(x) [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:x]]


#ifdef DEBUG
#	define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#	define DLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

