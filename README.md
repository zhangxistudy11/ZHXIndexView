![image](https://github.com/zhangxistudy11/ZHXIndexView/blob/master/ZHXIndexView/Source/normal.jpg)
# ZHXIndexView
---------------------------------------------------------
[![](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/zhangxistudy11/ZHXIndexView)
[![](https://img.shields.io/badge/tag-0.0.1-brightgreen.svg)](https://github.com/zhangxistudy11/ZHXIndexView/tree/0.0.1)
[![](https://img.shields.io/badge/language-ObjectC-brightgreen.svg)](https://github.com/zhangxistudy11/ZHXIndexView)
[![](https://img.shields.io/badge/中文-文档-brightgreen.svg)](https://www.jianshu.com/p/00a09e342062)

· A simple indexing tool for both UITableView and UICollectionVIew.

[中文文档地址](https://www.jianshu.com/p/00a09e342062)
# Table of Contents
---------------------------------------------------------
[· Background](# Background)
[· DisplayEffect](# DisplayEffect)
[· Install](# Install)
[· Usage](# Usage)
[· API](# API)
[· License](# License)

# Background
---------------------------------------------------------
Since the iOS system comes with a single index effect, and does not support UICollectionView. When you use it, you need to write it yourself. Although the code is not complicated, it is not necessary to reinvent the wheel. Here I provide a packaged ZHXIndexVeiew that supports UITableView and UICollectionView.

# DisplayEffect
---------------------------------------------------------

basics：

![image](https://github.com/zhangxistudy11/ZHXIndexView/blob/master/ZHXIndexView/Source/basic.gif)


highlight：

![image](https://github.com/zhangxistudy11/ZHXIndexView/blob/master/ZHXIndexView/Source/Not-selected-by-default.gif)

indicator：

![image](https://github.com/zhangxistudy11/ZHXIndexView/blob/master/ZHXIndexView/Source/indicator.gif)

for tableview:

![image](https://github.com/zhangxistudy11/ZHXIndexView/blob/master/ZHXIndexView/Source/tableview.gif)

# Install
---------------------------------------------------------
1. Download  [ZHXIndexView](https://github.com/zhangxistudy11/ZHXIndexView)
 and introduce ZHXIndexView.h and ZHXIndexView.m files into your project.
 The red content is the file you want to import, and the blue file is Demo, you can see my specific use.
 ![image]( https://github.com/zhangxistudy11/ZHXIndexView/blob/master/ZHXIndexView/Source/file-path.jpg)
2. If you use Cocoapods for your project, you can use the command line.
```
pod 'ZHXIndexView', '~> 0.0.1'
```

# Usage
---------------------------------------------------------
1. Basic use: add indexView to the current page
```
     /*
     the frame here must be set correctly, the width and height of the indexView are determined here.
     The height of a single item is given by the (height/ indexTitles.count )
     */
    self.indexView = [[ZHXIndexView alloc]initIndexViewWithFrame:CGRectMake(ScreenWidth-24, 180, 24, 550)];
    [self.view addSubview:self.indexView];
    /*
     pay attention to setting the proxy method
     */
    self.indexView.delegate = self;
    self.indexView.itemTitleColor = [UIColor colorWithString:@"#999999"];
    self.indexView.itemTitleFont = [UIFont systemFontOfSize:10];
    /*
     Assigning values to data sources is best left behind to ensure that other required attributes have been assigned
     */
    self.indexView.indexTitles = self.indexData;
```

 
