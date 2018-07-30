#GitHubKEY = #上文生成的 GitHub Personal Access Token
GitHubEMail = "npofsi@outlook.com" #你绑定在 GitHub 上的邮箱地址
GitHubUser = "npofsi" #你的 GitHub 用户名
GitHubRepo = "MyBlog" #静态页面 deploy 的目标仓库名称

cd ./public # Hexo 生成的目录默认在 public 下
git init # 初始化一个 Repo
git config --global push.default matching
git config --global user.email "${GitHubEMail}"
git config --global user.name "${GitHubUser}" # 利用在环境变量中定义的信息配置 Git
git add --all .
git commit -m "refactor:Auto Builder of ${GitHubUser}'s Blog" # commit 信息
git push --quiet --force https://${GitHubKEY}@github.com/${GitHubUser}/${GitHubRepo}.git master # 将生成的静态整站部署到指定 Repo 的 master 分支。