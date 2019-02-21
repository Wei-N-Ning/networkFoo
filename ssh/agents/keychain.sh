#!/usr/bin/env bash

: <<"COMMENT" 
// what is a keychain?
https://developer.apple.com/library/archive/technotes/tn2449/_index.html

Prior to macOS Sierra, ssh would present a dialog asking for your passphrase 
and would offer the option to store it into the keychain. This UI was deprecated 
some time ago and has been removed.

Instead, a new UseKeychain option was introduced in macOS Sierra allowing 
users to specify whether they would like for the passphrase to be stored 
in the keychain. This option was enabled by default on macOS Sierra, which 
caused all passphrases to be stored in the keychain


// Is Keychain a platform agnostic feature?
https://www.michelebologna.net/2018/automatically-add-ssh-keys-to-ssh-agent-running-in-gnome-and-macos/

Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/[your-private-key-rsa]
  IdentityFile ~/.ssh/[your-private-key-ed25519]

Now, if you share the same ~/.ssh/config file between GNU/Linux and macOS 
 you would encounter an error: how ssh on Linux is supposed to know about 
  UseKeychain option (which is compiled only in macOS’ ssh)?

A special instruction, IgnoreUnkown, comes to the rescue:

IgnoreUnknown UseKeychain
UseKeychain yes

COMMENT



