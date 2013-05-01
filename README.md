# get-shit-done.rb

This is a Ruby version of Get-Shit-Done done by Vic Cherubini, https://github.com/leftnode/get-shit-done

It has minor differences, and the configuration is not the same, sorry!

## Installation

Put the script in your $PATH, where both your user and root have access.

On OSX, that could be ´/usr/bin´ or ´/usr/local/bin´ for more info see the discussion here: http://hivelogic.com/articles/using_usr_local/

    mv get-shit-done.rb /usr/local/bin

## Usage

By default the script blocks access to ´reddit.com´ and ´news.ycombinator.com´.

To begin, do this:

    $ sudo get-shit-done.rb start

To stop working, and start playing do this:

    $ sudo get-shit-done.rb stop

If you want to add your own, place them in ´~/.blockhosts´ in this form:

```
reddit.com
slashdot.org
newz.dk
news.ycombinator.com
```