# WOWX

> An AppleScript to launch all your WoW accounts all in once.

## Prerequisite

- Add all your WoW accounts information in your Keychain with `wowx` as name, account email as account and password as password.
```shell
security add-generic-password -s 'wowx'  -a 'your@account.email' -w 'your_password'
```
- Install `cliclick`
```shell
brew install cliclick
```
- Put all the accounts email in the [`wowx.applescript:3`](https://github.com/dqisme/wowx/blob/main/wowx.applescript#L3)
```applescript
set wowInstances to {{account:"your@account.email", pid:false}, {account:"your@another_account.email", pid:false}}
```

## Get Started

You can run the script directly. Also you can export it as an application and save it in the `/Applications` by the Script Editor.


