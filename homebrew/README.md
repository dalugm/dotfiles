# Backup

    brew list --formula > brew-formula.txt
    brew list --cask > brew-cask.txt

    # don't record dependency
    brew leaves > brew.txt

    brew cask list > brew-cask.txt # DEPRECATED since HOMEBREW v2.50

# Install

1. First way

``` shell
brew install $(cat brew.txt)
brew install --cask $(cat brew-cask.txt)

brew cask install $(cat brew-cask.txt) # DEPRECATED since HOMEBREW v2.50
```
Or use `for` function in shell (which is unnecessary since `cat` has already done this):

``` shell
for i in $(cat brew.txt); do;
    brew install "$1";
done

for i in $(cat brew-cask.txt); do;
    brew cask install "$1";
done
```

2. Second way

``` shell
xargs brew install < brew.txt
xargs brew cask install < brew-cask.txt
```

# Use mirror
## 首次安装 Homebrew

官网上提供的安装脚本是 `/bin/bash -c "$(curl -fsSL
https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"` ，为了加速克隆的速度，你需要下载
`https://raw.githubusercontent.com/Homebrew/install/master/install.sh` 并编辑其中的：

```shell
BREW_REPO="https://github.com/Homebrew/brew"
# 变成：
BREW_REPO="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
```

接着，运行 `install.sh` 以安装 Homebrew：

``` shell
HOMEBREW_CORE_GIT_REMOTE=https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git bash install.sh
```

这样在首次安装的时候也可以使用镜像。

## 替换现有上游

``` shell
# brew 程序本身，Homebrew/Linuxbrew 相同
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

# 以下针对 mac OS 系统上的 Homebrew
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
git -C "$(brew --repo homebrew/cask-fonts)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git
git -C "$(brew --repo homebrew/cask-drivers)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-drivers.git

# 以下针对 Linux 系统上的 Linuxbrew
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/linuxbrew-core.git

# 更换后测试工作是否正常
brew update
```

## 复原

``` shell
# brew 程序本身，Homebrew/Linuxbrew 相同
git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew.git

# 以下针对 mac OS 系统上的 Homebrew
git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://github.com/Homebrew/homebrew-cask.git
git -C "$(brew --repo homebrew/cask-fonts)" remote set-url origin https://github.com/Homebrew/homebrew-cask-fonts.git
git -C "$(brew --repo homebrew/cask-drivers)" remote set-url origin https://github.com/Homebrew/homebrew-cask-drivers.git

# 以下针对 Linux 系统上的 Linuxbrew
git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/linuxbrew-core.git

# 更换后测试工作是否正常
brew update
```

## 安装 Linuxbrew 时使用 tuna 镜像 (可用 `sudo`)

0. 安装 git

1. 下载 `https://raw.githubusercontent.com/Linuxbrew/install/master/install-ruby`

2. 将其中 `https://homebrew.bintray.com/bottles-portable-ruby/` 换为 `https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/bottles-portable-ruby/`

3. 运行 `./install-ruby` 安装 portable ruby

4. `export PATH=/home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby/current/bin:$PATH` # ==> Add Ruby to your PATH

5. 下载 `https://raw.githubusercontent.com/Linuxbrew/install/master/install`

6. 将其中 `https://github.com/Homebrew/brew` 换为 `https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git`

7. 运行 `./install` 安装 brew

8. 执行到 `==> Tapping homebrew/core` 时 <kbd>Ctrl-C</kbd>

9. `export PATH=/home/linuxbrew/.linuxbrew/Homebrew/bin:$PATH` # 将 brew 添加到 PATH

10. `git clone https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/linuxbrew-core.git "$(brew --repo homebrew/core)"`

11. 再次运行 `./install` 即可到达安装成功结果
