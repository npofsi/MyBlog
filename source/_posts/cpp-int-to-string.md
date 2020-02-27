---
title: 将数字转换成字符串
date: 2018-09-9 15:23:21 +0800 GMT
tags:
- CPP
- NOIp
---
今天碰到一个需要高效的将数字转换成字符串并连接起来的题，本来想用 `+'0'` 的办法 但这样效率实在不高，而我想知道有没有更简便的办法同时做到这两个工作，我就想 cpp 的流是不是能为我所用。果然，我找到了 `<sstream>` 这个头，其中的 `stringstream` 正合我意。于是就有了以下的转换操作：
```C++
stringstream sst ;
for(...) sst<<i ;
string str = sst.str() ;
```
