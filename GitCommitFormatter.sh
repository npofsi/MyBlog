#!/bin/sh

message="";

#2 > GitFormatError.txt

echo ""
echo "  欢迎使用gitCommit格式化工具"
echo ""
echo "    (0) feat:新功能（feature）"
echo "    (1) fix :修补bug"
echo "    (2) docs:文档相关更新（documentation）"
echo "    (3) style:代码格式变化（不影响运行）"
echo "    (4) refactor:重构（既不新增也不修复bug）"
echo "    (5) perf:提高性能"
echo "    (6) test:测试相关更新"
echo "    (7) chore:构建过程或辅助工具的变动"
echo "    (8) cleanup:不影响代码逻辑的提交"
echo "    (9) tracking:跟踪相关提交"
echo ""

typeArray=("feat" "fix" "docs" "style" "refactor" "perf" "test" "chore" "cleanup" "tracking")

inputType(){

	stype=0;

	read -p "  选择commit类型 (0):" stype

	if [[ $stype =~ ^-?[0-9]+$ && $stype -lt ${#typeArray[@]} ]] #&& $stype -lt ${#typeArray}
	then
		typee="${typeArray[$stype]}"
		message="${message}${typeArray[$stype]}"
	else
		echo "  [Error]参数错误"
		inputType
	fi
}

inputType
echo "  TYPE:${typee}"

inputScope(){

	scopee=""

	read -p "  输入这次commit的影响范围(空):" scopee

	if [[ ${#scopee} -gt 0 ]]
	then
		scopee="(${scopee})"
		message="${message}${scopee}:"
	else
		message="${message}:"
	fi
}

inputScope
echo "  SCOPE:${scopee}"

inputSubject(){

	subject=""

	read -p "  简单描述这次commit(空):" subject

	if [[ ${#subject} -gt 0 && $(( ${#message} + ${#subject} )) -lt 100 ]]
	then
		message="${message} ${subject}"
	else
		echo "  [Error]没有描述或描述过长"
		inputSubject
	fi
}

inputSubject
echo "  SUBJECCT:${subject}"

inputBody(){

	body=""

	read -p "  输入commit正文(空):" body

	if [[ ${#body} -gt 0 ]]
	then
		message="${message}\n\n${body}"
	fi
}

#inputBody
#echo "  BODY:${body}"

inputFooter(){

	
	
	footer=""

	read -p "  输入commit尾部(空):" footer

	if [[ ${#footer} -gt 0 ]]
	then
		message="${message}\n\n${footer}"
	fi
}

#inputFooter
#echo "  FOOTER:${footer}"

message="${message}\n#\n#Write body here....\n#\n#BREAKING CHANGE: \n#\n#Closes "

text=$(echo -e "$message")

echo ""

git commit -m "${text}"

git commit --amend