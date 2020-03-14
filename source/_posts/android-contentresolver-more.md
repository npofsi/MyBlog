---
title: Android ContentProvider 使用小计
date: 2019-03-14 9:54:28
categories:
- Tip
tags: 
- Android
- Code
---

Android 应用在选取文件时推荐使用 `Intent.ACTION_GET_CONTENT` 意图，而不是使用应用自己创建的文件选择器并获取读取文件权限。

因为从 Android Marshmallow 开始 Android 权限管理开始变得更加整顿严谨，几个版本以来  Android 解决了权限管理松散的问题。

其实 `ContentProvider` 并不是什么新事物，在 Android 中一直存在着，但随着权限的明确划分，权限的索取要更加的明确，否则会极大的影响用户体验，这时使用系统给予的机制会更加符合操作逻辑，也可以减少工作量。

<!-- more -->

下面是一个选取文件的简单使用场景


```java
//需要指定一个 int 来定位返回值
final int REQUEST_GET_CONTENT=1

//调用系统文件选择器
public void getContent() {
	Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
	intent.setType("*/*");
	intent.addCategory(Intent.CATEGORY_OPENABLE);
	startActivityForResult(intent, REQUEST_GET_CONTENT);
}
```

```java
//接受 URI
@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data) {
	super.onActivityResult(requestCode, resultCode, data);
	if (resultCode == RESULT_OK) {
		switch (requestCode) {
			case REQUEST_GET_CONTENT:
				Uri uri=data.getData();
				break;
		}
	}
}
```

之后要读取这个文件的内容只需要调用 `getContentResolver().openInputStream(uri)` 就可以了

但是！

这里有个问题

这样得不到文件的名字

直到我在 Android 文档里翻了又翻翻了又翻翻了又翻————官方还是很良心的，只是忘了用一下搜索功能。。。。

```java
public String getContentName(Uri uri) {
	String result = null;
	if (uri.getScheme().equals("content")) {
		Cursor cursor = this.getContentResolver().query(uri, null, null, null, null);
		try {
			if (cursor != null && cursor.moveToFirst()) {
				result = cursor.getString(cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME));
			}
		} finally {
			cursor.close();
		}
	}
	if (result == null) {
		result = uri.getPath();
		int cut = result.lastIndexOf('/');
		if (cut != -1) {
			result = result.substring(cut + 1);
		}
	}
	return result;
}

```

文档里直接把这个函数给出来了，就直接拿来放心用就好了

后来搜索相关的东西的时候在 stackoverflow 也发现了这个话题，回答是一样的。

这些基本就是选取文件完全方法了，虽然很水，不过写出来就不容易忘了吧

以上
