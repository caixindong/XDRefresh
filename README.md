# XDRefresh
简易版上下拉刷新控件，原理是通过观察scrollview的contentOffset属性的变化来进行处理

#effect diagram
![image](https://github.com/caixindong/XDRefresh/blob/master/XDRefreshDemo.gif)

#How To Use

##init
```ObjC
#import "KitRefresh.h"
...
KitRefreshHeader *_header;
KitRefreshFooter *_footer;

_header =  [KitRefreshHeader headerOfScrollView:tableView withRefreshingBlock:^{
  			//下拉刷新回调
    }];
    
_footer = [KitRefreshFooter footerOfScrollView:tableView withRefreshingBlock:^{
        //上拉刷新回调
    }];

```

##refresh
```ObjC
[_header beginRefreshing];
[_header endRefreshing];
```

##no more data status
```ObjC
[_footer endRefreshingWithNoMoreDataWithTitle:@"无数据了"];
//重设状态
 [_footer resetNoMoreData];
```

#Extension For Future
提供更多自定义的选择，如改变动画、自定义刷新控件。。。

