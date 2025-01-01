#!/usr/bin/perl

# obmenu-generator - schema file

=for comment

    item:      add an item inside the menu               {item => ["command", "label", "icon"]},
    cat:       add a category with items                  {cat => ["name", "label", "icon"]},
    subcats:   add a category with subcategories      {subcats => ["name", "label", "icon"]},
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

## Text editor
my $editor = $CONFIG->{editor};

our $SCHEMA = [

    {sep => 'ИЗБРАННОЕ'},

    #          COMMAND              LABEL          ICON
    {item => ['xdg-open .',        'Файлы',       'system-file-manager']},
    {item => ['alacritty -e vifm', 'Vifm',        'system-file-manager']},
    {item => ['xdg-terminal',      'Терминал',    'utilities-terminal']},
    {item => ['xdg-open http://',  'Браузер',     'web-browser']},

    {sep => 'КАТЕГОРИИ'},

    #         NAME                  LABEL          ICON
    {cat => ['utility',            'Утилиты',     'applications-utilities']},
    {cat => ['development',        'Разработка',  'applications-development']},
    {cat => ['education',          'Обучение',    'applications-science']},
    {cat => ['game',               'Игры',        'applications-games']},
    {cat => ['graphics',           'Графика',     'applications-graphics']},
    {cat => ['audiovideo',         'Мультимедиа', 'applications-multimedia']},
    {cat => ['network',            'Сеть',        'applications-internet']},
    {cat => ['office',             'Оффис',       'applications-office']},
    {cat => ['other',              'Другие',      'applications-other']},
    {cat => ['settings',           'Настройки',   'applications-accessories']},
    {cat => ['system',             'Система',     'applications-system']},

    #             LABEL          ICON
    #{beg => ['My category',  'cat-icon']},
    #          ... some items ...
    #{end => undef},

    #            COMMAND     LABEL        ICON
    #{pipe => ['obbrowser', 'Disk', 'drive-harddisk']},

    ## Generic advanced settings
    #{sep       => undef},
    #{obgenmenu => ['Openbox Settings', 'applications-engineering']},
    #{sep       => undef},

    {sep => "СЕССИЯ"},
    ## Custom advanced settings
    # Configuration files
    {beg => ['Настройки окружения', 'applications-engineering']},
        {sep => undef},
    # obmenu-generator category
    {beg => ['Obmenu-Generator', 'accessories-text-editor']},
        {item => ["$editor ~/.config/obmenu-generator/schema.pl", 'Menu Schema', 'text-x-generic']},
        {item => ["$editor ~/.config/obmenu-generator/config.pl", 'Menu Config', 'text-x-generic']},
        {sep  => undef},
        {item => ['obmenu-generator -s -c', 'Generate a static menu', 'accessories-text-editor']},
        {item => ['obmenu-generator -s -i -c', 'Generate a static menu with icons', 'accessories-text-editor']},
        {sep  => undef},
        {item => ['obmenu-generator -p', 'Generate a dynamic menu', 'accessories-text-editor']},
        {item => ['obmenu-generator -p -i', 'Generate a dynamic menu with icons', 'accessories-text-editor']},
        {sep  => undef},
        {item => ['obmenu-generator -d', 'Refresh cache', 'view-refresh']},
    {end => undef},
    {sep => undef},
    # Openbox category
    {beg => ['Openbox', 'openbox']},
        {item => ["$editor ~/.config/openbox/autostart", 'Openbox Autostart', 'text-x-generic']},
        {item => ["$editor ~/.config/openbox/rc.xml", 'Openbox RC', 'text-x-generic']},
        {item => ["$editor ~/.config/openbox/menu.xml", 'Openbox Menu', 'text-x-generic']},
        {item => ['openbox --reconfigure', 'Reconfigure Openbox', 'openbox']},
        {item => ['openbox --restart', 'Restart Openbox', 'openbox']},
    {end => undef},
    {end => undef},
    {sep => undef},
    {item => ['light-locker-command -l', 'Заблокировать', 'system-lock-screen']},
    {sep => undef},
    ## This option uses the default Openbox's "Exit" action
    {exit => ['Выйти', 'application-exit']},
    {sep => undef},
]
