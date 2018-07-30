
cd ./public # Hexo 生成的目录默认在 public 下
echo "blog.npofsi.pro" > ./CNAME
git init # 初始化一个 Repo
git config --global push.default matching
git config --global user.email "${GitHubEMail}"
git config --global user.name "${GitHubUser}" # 利用在环境变量中定义的信息配置 Git
git add --all .
git commit -m "refactor:Auto Builder of ${GitHubUser}'s Blog" # commit 信息
git push --quiet --force https://${GitHubKEY}@github.com/${GitHubUser}/${GitHubRepo}.git master # 将生成的静态整站部署到指定 Repo 的 master 分支。