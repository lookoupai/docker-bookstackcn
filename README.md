# bookstackcn-docker

BookStack，基于MinDoc，使用Beego开发的在线文档管理系统，功能类似Gitbook和看云。 http://www.bookstack.cn

https://github.com/TruthHun/BookStack

## docker部署bookstack

1. 运行mysql容器

使用官方最新版本mysql镜像，根据实际情况修改数据库root密码，数据库名及登录用户名密码

官方镜像地址：https://hub.docker.com/_/mysql

```
docker run -itd --name mysql \
  --restart always \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=bookstack \
  -e MYSQL_DATABASE=bookstack \
  -e MYSQL_USER=bookstack \
  -e MYSQL_PASSWORD=bookstack \
  -v /data/mysql:/var/lib/mysql \
  mysql --default-authentication-plugin=mysql_native_password
```

2. 修改bookstack配置文件
   从https://github.com/TruthHun/BookStack上下载Release版本，复制conf至/data/bookstack/conf并更改对应配置

3. bookstack启动时会连接mysql，依赖mysql来存储数据。
```
docker run -itd --name bookstack \
  --restart always \
  -p 8181:8181 \
  -v /data/bookstack/conf:/opt/bookstack/conf \
  toplinker/bookstack
```

默认管理员账号和密码为 admin/admin888

http://192.168.1.1:8181

## 中文乱码
使用官方MYSQL的话，因为默认不是uft-8，中文内容都是 ？号
需要自己设置成uft-8，或者找别的镜像，比如https://hub.docker.com/r/dnhsoft/mysql-utf8

## 时区问题
默认latest时没有设置时区的，时区是UTC，需要自己设置
Tags2.8已经修改默认时区为Asia/Shanghai

## 挂载目录
  -v /data/BookStack/conf:/opt/bookstack/conf \ #配置文件夹

  -v /data/BookStack/views:/opt/bookstack/views \ #模板文件夹

  -v /data/BookStack/uploads:/opt/bookstack/uploads \ #上传附件文件夹（包括图片，文件等）

  -v /data/BookStack/version_control:/opt/bookstack/version_control \ #历史版本文件夹

要自用的话要修改的地方挺多的，还没试过能不能直接挂载整个bookstack，能的话应该方便点，不用挂载那么多目录

构建镜像目前没有安装puppeteer
