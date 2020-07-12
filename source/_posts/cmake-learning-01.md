---
title: CMake 学习小结
date: 2020-07-12 17:47:28
categories:
- Summary
tags: 
- C/C++
- Code
---

高考完这段时间点子大概比较多？既然学了两年的信息学奥赛写了两年 C++ ，却根本不会用 C++ 去做开发，这次正好想做的一个东西对性能要求比较高，就考虑用 C++ 来做，又因为原来一直用的 Java 导致我比较关注多平台的兼容，就想趁机学习一下 CMake 这类通用构建工具。这篇文章会列举一下我学到的 CMake 常用的命令，做一个小结。

如果想要学习 CMake ，非常推荐 [CMake 官方提供的教程](https://cmake.org/cmake/help/latest/guide/tutorial/index.html) ，跟下来的话 CMake 基本就可以掌握了。

<!-- more -->

##### 基本信息

这些就是些必填的东西

```cmake
cmake_minimum_required (VERSION 3.8)

project (<PROJECT_NAME>)

```

##### 子目录

用来标记该项目要使用到（存在 CMakeLists.txt）的子目录

```cmake
add_subdirectory(<PATH>)
```

##### 编译可执行文件

将标记的源代码文件编译成可执行文件

```cmake
add_executable(<EXEC_FILE_NAME> <SOURCE_CODE_FILE。..>)
```

##### 编译库文件

将标记的源代码文件编译成为链接库文件

```cmake
add_library(<LIB_FILE_NAME> <SOURCE_CODE_FILE。..>)
```

##### 安装

关于 install 的用法极多，具体还是查阅手册比较好 在我项目里用来引入 Duktape 库 `install(TARGETS duktape DESTINATION lib)`

```cmake
install(...)
```

##### 预编译库的引入

一个 `EXEC_FILE_NAME` 或 `EXEC_FILE_NAME` 可作为 `TARGET_NAME` ，本质上是将该预编译库链接在 obj 文件中，**这也就是说需要先存在一个 `EXEC_FILE_NAME` 或 `EXEC_FILE_NAME`，请保证调用此命令前调用过相应的 `add_executable` 或 `add_library`，否则会报 ` Cannot specify include directories when use target target_include_directories` 错误**

```cmake
target_link_libraries(<TARGET_NAME> <PUBLIC|SHARED|PRIVATE> <LIB_NAME>)
```

##### 头文件目录的引入

经常要用的，我的项目中是用了很多 stb 项目的头文件 `target_include_directories(${PROJECT_NAME} PUBLIC stb)`，**`TARGET_NAME` 的要求同上**

```cmake
target_include_directories(<TARGET_NAME> <PUBLIC|SHARED|PRIVATE> <DIR_NAME>)
```

##### 获取文件夹下所有源文件

将根目录下所有文件文件名转储到一个变量里，在添加可执行文件时的例子： `add_executable (${PROJECT_NAME} ${<VARIABLE_NAME>})"`

```cmake
aux_source_directory(. <VARIABLE_NAME>)
```

##### 生成 Config 文件

在编译时生成 config 文件以便在不同要求，不同操作系统下编译或输出文件

```cmake
configure_file(Config.h.in Config.h)
```