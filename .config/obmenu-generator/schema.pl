#!/usr/bin/perl
# obmenu-generator - schema file

=for comment

    item:      add an item inside the menu          {item => ["command", "label", "icon"]},
    cat:       add a category inside the menu       {cat => ["name", "label", "icon"]},
    sep:       horizontal line separator            {sep => undef}, {sep => "label"},
    pipe:      a pipe menu entry                    {pipe => ["command", "label", "icon"]},
    file:      include the content of an XML file   {file => "/path/to/file.xml"},
    raw:       any XML data supported by Openbox    {raw => q(...)},
    beg:       begin of a category                  {beg => ["name", "icon"]},
    end:       end of a category                    {end => undef},
    obgenmenu: generic menu settings                {obgenmenu => ["label", "icon"]},
    exit:      default "Exit" action                {exit => ["label", "icon"]},

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

#         COMMAND        LABEL          ICON
{beg => [               "Launch Apps", "$ENV{HOME}/.icons/Gladient/find.png"]},
{cat => ["utility",     "Accessories", "applications-utilities"]},
{sep => undef},
{cat => ["development", "Development", "applications-development"]},
{sep => undef},
{cat => ["education",   "Education",   "applications-science"]},
{cat => ["game",        "Games",       "applications-games"]},
{sep => undef},
{cat => ["graphics",    "Graphics",    "applications-graphics"]},
{cat => ["audiovideo",  "Multimedia",  "applications-multimedia"]},
{sep => undef},
{cat => ["network",     "Network",     "applications-internet"]},
{cat => ["office",      "Office",      "applications-office"]},
{sep => undef},
{cat => ["other",       "Other",       "applications-other"]},
{sep => undef},
{cat => ["settings",    "Settings",    "applications-accessories"]},
{sep => undef},
{cat => ["system",      "System",      "applications-system"]},
{end => undef},

{sep => undef},

{item => ["$ENV{HOME}/.local/bin/launch-apps.sh terminal", "Open Terminal", "$ENV{HOME}/.icons/Gladient/terminal.png"]},

{sep => undef},
    
{item => ["$ENV{HOME}/.local/bin/launch-apps.sh file_manager", "Open File Manager",	"$ENV{HOME}/.icons/Gladient/file-manager.png"]},

{sep => undef},

{beg => ["Screenshot", "$ENV{HOME}/.icons/Gladient/screenshot.png"]},
{item => ["$ENV{HOME}/.local/bin/screenshot-screen.sh delay", "Screen", "$ENV{HOME}/.icons/Gladient/screenshot.png"]},
    
{sep => undef},
    
{item => ["$ENV{HOME}/.local/bin/screenshot-selection.sh", "Select or Draw", "$ENV{HOME}/.icons/Gladient/screenshot.png"]},
    
{sep => undef},
    
{item => ["$ENV{HOME}/.local/bin/screenshot-countdown.sh", "Countdown ?s", "$ENV{HOME}/.icons/Gladient/screenshot.png"]},
{end => undef},

{sep => undef},

{item => ["lxrandr", "Monitor Settings", "$ENV{HOME}/.icons/Gladient/monitor-settings.png"]},

{sep => undef},
    
{obgenmenu => ["Advanced Settings", "$ENV{HOME}/.icons/Gladient/advanced-settings.png"]},

{sep => undef},

{sep => "SESSIONS"},

{beg => ["Appearance", "$ENV{HOME}/.icons/Gladient/appearance.png"]},
{item => ["waypaper", "Change Wallpaper", "$ENV{HOME}/.icons/Gladient/wallpaper.png"]},
    
{sep => undef},
    
{item => ["$ENV{HOME}/.config/openbox/joyful-desktop/ob-button-set.sh", "Change Window Button-Style", "$ENV{HOME}/.icons/Gladient/ob-button-change.png"]},
    
{sep => undef},
    
{item => ["$ENV{HOME}/.config/openbox/joyful-desktop/ob-button-set.sh swap", "Swap Window Button-Location", "$ENV{HOME}/.icons/Gladient/ob-button-swap.png"]},
    
{sep => undef},
    
{item => ["$ENV{HOME}/.config/openbox/joyful-desktop/toggle-mode.sh mode", "Toggle Mode", "$ENV{HOME}/.icons/Gladient/mode.png"]},
    
{sep => undef},
    
{item => ["$ENV{HOME}/.config/openbox/joyful-desktop/toggle-mode.sh", "Switch Theme", "$ENV{HOME}/.icons/Gladient/theme.png"]},
    
{end => undef},

{sep => undef},

{item => ["$ENV{HOME}/.config/openbox/joyful-desktop/toggle-mode.sh apply", "Restart UI", "$ENV{HOME}/.icons/Gladient/restart-ui.png"]},

{sep => undef},

{item => ["loginctl --no-ask-password lock-session", "Lock", "$ENV{HOME}/.icons/Gladient/lock.png"]},

{sep => undef},

{exit => ["Exit Openbox", "$ENV{HOME}/.icons/Gladient/logout.png"]},
]
