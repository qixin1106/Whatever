/******************************************************************************/
//TODO: 屏幕
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//TODO: 颜色
#define RGB(R,G,B) [SKColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define RGBA(R,G,B,A) [SKColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//TODO: Log
#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__)
#else
#define NSLog(...)
#endif

//TODO: 设备
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//TODO: 角度/弧度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)
/******************************************************************************/

#define MAP_LAYER 0
#define CHARACTER_LAYER 100
#define BULLET_LAYER 101
#define HP_BAR_LAYER 1000



/******************************************************************************/

#define FRIEND_NAME @"FRIEND_NAME"
#define ENEMY_NAME @"ENEMY_NAME"

/******************************************************************************/

