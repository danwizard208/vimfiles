#!/usr/bin/perl

open PLUGINS, "plugins";
@plugins = <PLUGINS>;
foreach $plugin (@plugins)
{
    # Plugins lines start with +<space>; ignore other lines
    # (this was added to enable a vim modeline in the plugins file)
    if($plugin ~= /^\+ /)
    {
        $plugin =~ s/^\+ //;
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
        else
        {
            # The plugin already has a directory; pull latest from repo
            chdir $name;
            print "Running 'git pull' on $name\n";
            system("git pull");
            chdir "..";
        }
    }
}
