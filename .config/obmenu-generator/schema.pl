#!/usr/bin/env perl

# obmenu-generator - schema file
# https://github.com/owl4ce/dotfiles

=for comment

    item:      add an item inside the menu               {item => ["command", "label", "icon"]},
    cat:       add a category inside the menu             {cat => ["name", "label", "icon"]},
    sep:       horizontal line separator                  {sep => undef}, {sep => "label"},
    pipe:      a pipe menu entry                         {pipe => ["command", "label", "icon"]},
    file:      include the content of an XML file        {file => "/path/to/file.xml"},
    raw:       any XML data supported by Openbox          {raw => q(...)},
    beg:       begin of a category                        {beg => ["name", "icon"]},
    end:       end of a category                          {end => undef},
    obgenmenu: generic menu settings                {obgenmenu => ["label", "icon"]},
    exit:      default "Exit" action                     {exit => ["label", "icon"]},

=cut

# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to an icon or a valid icon name
#    * Category names are case insensitive. (X-XFCE and x_xfce are equivalent)

require "$ENV{HOME}/.config/obmenu-generator/config.pl";

# Text editor
my $editor = $CONFIG->{editor};

our $SCHEMA = [
    {sep       => "QUICK START"},

    #              COMMAND                                                              LABEL                          ICON
    {beg       => [                                                                     "Launch Apps",                 "$ENV{HOME}/.local/share/icons/Gladient/find.png"]},
    {cat       => ["utility",                                                           "Accessories",                 "applications-utilities"]},
    {cat       => ["development",                                                       "Development",                 "applications-development"]},
    {cat       => ["education",                                                         "Education",                   "applications-science"]},
    {cat       => ["game",                                                              "Games",                       "applications-games"]},
    {cat       => ["graphics",                                                          "Graphics",                    "applications-graphics"]},
    {cat       => ["audiovideo",                                                        "Multimedia",                  "applications-multimedia"]},
    {cat       => ["network",                                                           "Network",                     "applications-internet"]},
    {cat       => ["office",                                                            "Office",                      "applications-office"]},
    {cat       => ["other",                                                             "Other",                       "applications-other"]},
    {cat       => ["settings",                                                          "Settings",                    "applications-accessories"]},
    {cat       => ["system",                                                            "System",                      "applications-system"]},
    {end       => undef},

    {sep       => undef},

    {item      => ["$ENV{HOME}/.local/bin/launch-apps.sh terminal",                       "Open Terminal",               "$ENV{HOME}/.local/share/icons/Gladient/terminal.png"]},

    {sep       => undef},
    
    {item      => ["$ENV{HOME}/.local/bin/launch-apps.sh file_manager",                   "Open File Manager",           "$ENV{HOME}/.local/share/icons/Gladient/file-manager.png"]},

    {sep       => undef},

    {beg       => [                                                                     "Screenshot",                  "$ENV{HOME}/.local/share/icons/Gladient/screenshot.png"]},
    {item      => ["$ENV{HOME}/.local/bin/screenshot-screen.sh delay",                    "Screen",                      "$ENV{HOME}/.local/share/icons/Gladient/screenshot.png"]},
    
    {sep       => undef},
    
    {item      => ["$ENV{HOME}/.local/bin/screenshot-selection.sh",                       "Select or Draw",              "$ENV{HOME}/.local/share/icons/Gladient/screenshot.png"]},
    
    {sep       => undef},
    
    {item      => ["$ENV{HOME}/.local/bin/screenshot-countdown.sh",                       "Countdown ?s",                "$ENV{HOME}/.local/share/icons/Gladient/screenshot.png"]},
    
    {end       => undef},

    {sep       => undef},

    {pipe      => ["$ENV{HOME}/.config/openbox/pipe-menu/ob-randr.py",                  "Monitor Settings",            "$ENV{HOME}/.local/share/icons/Gladient/monitor-settings.png"]},

    {sep       => undef},
    
    {obgenmenu => [                                                                     "Advanced Settings",           "$ENV{HOME}/.local/share/icons/Gladient/advanced-settings.png"]},

    {sep       => undef},

    {sep       =>                                                                       "SESSIONS"},

    {beg       => [                                                                     "Appearance",                  "$ENV{HOME}/.local/share/icons/Gladient/appearance.png"]},
    {item      => [waypaper, "Change Wallpaper", "$ENV{HOME}/.local/share/icons/Gladient/wallpaper.png"]},
    
    {sep       => undef},
    
    {item      => ["$ENV{HOME}/.config/openbox/joyful-desktop/ob-button-set.sh",        "Change Window Button-Style",  "$ENV{HOME}/.local/share/icons/Gladient/ob-button-change.png"]},
    
    {sep       => undef},
    
    {item      => ["$ENV{HOME}/.config/openbox/joyful-desktop/ob-button-set.sh swap",   "Swap Window Button-Location", "$ENV{HOME}/.local/share/icons/Gladient/ob-button-swap.png"]},
    
    {sep       => undef},
    
    {item      => ["$ENV{HOME}/.config/openbox/joyful-desktop/toggle-mode.sh mode",     "Toggle Mode",                 "$ENV{HOME}/.local/share/icons/Gladient/mode.png"]},
    
    {sep       => undef},
    
    {item      => ["$ENV{HOME}/.config/openbox/joyful-desktop/toggle-mode.sh",          "Switch Theme",                "$ENV{HOME}/.local/share/icons/Gladient/theme.png"]},
    
    {end       => undef},

    {sep       => undef},

    {item      => ["$ENV{HOME}/.config/openbox/joyful-desktop/toggle-mode.sh apply",    "Restart UI",                  "$ENV{HOME}/.local/share/icons/Gladient/restart-ui.png"]},

    {sep       => undef},

    {item      => ["loginctl --no-ask-password lock-session",                           "Lock",                        "$ENV{HOME}/.local/share/icons/Gladient/lock.png"]},

    {sep       => undef},

    {exit      => [                                                                     "Exit Openbox",                "$ENV{HOME}/.local/share/icons/Gladient/logout.png"]},
]
