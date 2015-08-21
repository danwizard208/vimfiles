#!/usr/bin/perl

open PLUGINS, "plugins";
@plugins = <PLUGINS>;
foreach $plugin (@plugins)
{
    chomp($plugin);
    # Plugins stored as a name and url separated by a number of tabs
    ($name, $url) = split /\t+/,$plugin;
    chomp($name); chomp($url);
    if(!-e $name)
    {
        # The plugin doesn't have a directory yet; clone the url
        print "Running 'git clone $url'\n";
        system("git clone $url");
    }
    else
    {
        # The plugin already has a directory; pull latest from repo
        chdir $name;
        print "Running 'git pull' on $name\n";
        system("git pull");
        chdir "..";
    }
}
