# INSTALL

``` shell
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/gitignore ~/.gitignore
ln -s ~/dotfiles/git/gitmessage ~/.gitmessage
```

# Updating credentials from the macOS Keychain

You'll need to update your saved credentials in the git-credential-osxkeychain helper if you change your username, password, or personal access token on GitHub.

## Updating credentials via Keychain Access

1. Click on the Spotlight icon (magnifying glass) on the right side of the menu bar. Type Keychain access then press the Enter key to launch the app.

2. In Keychain Access, search for `github.com`.

3. Find the "internet password" entry for `github.com`.

4. Edit or delete the entry accordingly.

## Deleting credentials via the command line

Through the command line, you can use the credential helper directly to erase the keychain entry.

``` shell
$ git credential-osxkeychain erase
host=github.com
protocol=https
> [Press Return]
```

If it's successful, nothing will print out. To test that it works, try and clone a private repository from GitHub. If you are prompted for a password, the keychain entry was deleted.


# Adding SSH key to the ssh-agent

Before adding a new SSH key to the ssh-agent to manage your keys, you should have checked for existing SSH keys and generated a new SSH key.

When adding your SSH key to the agent, use the default macOS `ssh-add` command, and not an application installed by macports, homebrew, or some other external source.

1. Start the ssh-agent in the background.

   ``` shell
   $ eval "$(ssh-agent -s)"
   > Agent pid 59566
   ```

   Depending on your environment, you may need to use a different command. For example, you may need to use root access by running `sudo -s -H` before starting the ssh-agent, or you may need to use `exec ssh-agent bash` or `exec ssh-agent zsh` to run the ssh-agent.

2. If you're using macOS Sierra 10.12.2 or later, you will need to modify your `~/.ssh/config` file to automatically load keys into the ssh-agent and store passphrases in your keychain.

   Open your `~/.ssh/config file`, then modify the file to contain the following lines. If your SSH key file has a different name or path than the example code, modify the filename or path to match your current setup.

   ``` shell
   Host *
     AddKeysToAgent yes
     UseKeychain yes
     IdentityFile ~/.ssh/id_ed25519
   ```

   NOTE: If you chose not to add a passphrase to your key, you should omit the UseKeychain line.

   NOTE: If you see an error like this

   ``` shell
   /Users/USER/.ssh/config: line 16: Bad configuration option: usekeychain
   ```

   add an additional config line to your `Host *` section:

   ``` shell
   Host *
     IgnoreUnknown UseKeychain
   ```

3. Add your SSH private key to the ssh-agent and store your passphrase in the keychain. If you created your key with a different name, or if you are adding an existing key that has a different name, replace id_ed25519 in the command with the name of your private key file.

   ``` shell
   $ ssh-add -K ~/.ssh/id_ed25519
   ```

   NOTE: The `-K` option is Apple's standard version of `ssh-add`, which stores the passphrase in your keychain for you when you add an ssh key to the ssh-agent. If you chose not to add a passphrase to your key, run the command without the `-K` option.

4. Add the SSH key to your account on GitHub.
