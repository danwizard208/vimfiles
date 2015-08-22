#!/usr/bin/perl

#Like update-plugins.pl, but doesn't git pull on existing plugins

open PLUGINS, "plugins";
@plugins = <PLUGINS>;
foreach $plugin (@plugins)
{
    chomp($plugin);
    # Plugins stored as a name and url separated by a number of tabs
    ($name, $url) = split /\t+/,$plugin;
    chomp($name); chomp($url);
    unless(-e $name)
    {
        # The plugin doesn't have a directory yet; clone the url
        print "Running 'git clone $url'\n";
        system("git clone $url");
    }
}
