使用方法：
========

1. 把 diy-part1.sh 和 diy-part2.sh 覆盖到仓库根目录（替换原有文件）

2. 把 vnt2-bin/Makefile 覆盖到仓库的 vnt2-bin/Makefile（替换原有文件）

3. （可选但推荐）在仓库根目录跑一次本地检查：
       bash check_vnt2.sh
   确认输出全是 ✅ 再提交

4. 确认 .config（360t7.config / r30b1.config）里有这两行：
       CONFIG_PACKAGE_luci-app-vnt2=y
       CONFIG_PACKAGE_vnt2-bin=y

5. git add . && git commit -m "fix: 把 vnt2-bin cp 移到 diy-part1（feeds 之前）" && git push

6. 去 GitHub Actions 看编译日志


关键改动说明：
============
- vnt2-bin 的 cp 从 diy-part2.sh 移到了 diy-part1.sh
  （原因：必须在 feeds update/install 之前放入 package/，否则不会被扫描注册，导致 "package/vnt2-bin failed to build"）
- diy-part2.sh 里删除了重复的 rm/cp vnt2-bin，避免覆盖 feeds 已注册的符号链接
- Makefile 统一为 2.0.7、Tab 缩进、install 路径指向 files/aarch64/
