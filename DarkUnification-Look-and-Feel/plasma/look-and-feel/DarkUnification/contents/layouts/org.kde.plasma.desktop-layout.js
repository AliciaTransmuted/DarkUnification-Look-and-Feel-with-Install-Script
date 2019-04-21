// *****************************************************
// Initialize environment
// Remove desktop toolbox
// Set wallpaper
// *****************************************************
var plasma = getApiVersion(1)
var activityId = activityIds[0]
var activity = desktopById(activityId)
activity.writeConfig("immutability", 2)
activity.currentConfigGroup = ["General"]
activity.writeConfig("showToolbox", false)
activity.currentConfigGroup = ["Wallpaper", "org.kde.image", "General"]
activity.writeConfig("Image", "file:///home/xxUSERNAMExx/.local/share/plasma/look-and-feel/DarkUnification/contents/wallpaper/Wilted.jpg")

// *****************************************************
// Create Top Panel
// *****************************************************
panel = new plasma.Panel
panel.location = "top"
panel.alignment = "left"
panel.height = gridUnit * 2

// Add widgets to the top panel

// Make first spacer non expandable by default
var spacer = panel.addWidget("org.kde.plasma.panelspacer")
spacer.currentConfigGroup = ["Configuration", "General"]
spacer.writeConfig("expanding", false)

// Add Active Window Control to Top Panel
//     ...   https://store.kde.org/p/998910/
//     ...   added kns://plasmoids.knsrc/api.kde-look.org/998910 to X-KPackage-Dependencies= in metadata.desktop
activewindow = panel.addWidget("org.kde.activeWindowControl")
activewindow.writeConfig("buttonOrder", "close|minimize|maximize|alldesktops");
activewindow.writeConfig("buttonSize", "1");
activewindow.writeConfig("controlButtonsSpacing", "0");
activewindow.writeConfig("doNotHideControlButtons", true);
activewindow.writeConfig("horizontalScreenWidthPercent", "0.07");
activewindow.writeConfig("showMaximize", true);
activewindow.writeConfig("showMinimize", true);
activewindow.writeConfig("showWindowIcon", false);
activewindow.writeConfig("showWindowTitle", false);

// Add Global Menu to Top Panel
panel.addWidget("org.kde.plasma.appmenu")

// Add Panel Spacer to Top Panel
panel.addWidget("org.kde.plasma.panelspacer")

// Add Show Desktop to Top Panel
panel.addWidget("org.kde.plasma.showdesktop")

// Add System Tray to Top Panel
systtray = panel.addWidget("org.kde.plasma.systemtray")
systtray.writeConfig("showAllItems", true)
systtray.writeConfig("extraItems", "org.kde.discovernotifier,org.kde.plasma.mediacontroller,org.kde.plasma.volume,org.kde.plasma.bluetooth,org.kde.kdeconnect,org.kde.plasma.notifications,org.kde.plasma.vault,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.networkmanagement,org.kde.plasma.printmanager,org.kde.plasma.battery")
systtray.writeConfig("knownItems", "org.kde.discovernotifier,org.kde.plasma.mediacontroller,org.kde.plasma.volume,org.kde.plasma.bluetooth,org.kde.kdeconnect,org.kde.plasma.notifications,org.kde.plasma.vault,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.networkmanagement,org.kde.plasma.printmanager,org.kde.plasma.battery")

// Add Digital Clock to Top Panel
clock = panel.addWidget("org.kde.plasma.digitalclock")
clock.writeConfig("showDate", true);
clock.writeConfig("dateFormat", "longDate");
clock.writeConfig("showDay", true);
clock.writeConfig("showSeconds", false);
clock.writeConfig("showYear", true);
clock.writeConfig("showLocalTimezone", true);
clock.writeConfig("displayTimezoneAsCode", false);

// Add USwitch to Top Panel
//     ...   https://store.kde.org/p/1194339/
//     ...   added kns://plasmoids.knsrc/api.kde-look.org/1194339 to X-KPackage-Dependencies= in metadata.desktop
var uswitcher= panel.addWidget("org.kde.plasma.uswitcher")
uswitcher.currentConfigGroup = ["Configuration", "General"]
uswitcher.writeConfig("showFace", true)
uswitcher.writeConfig("showFullName", false)
uswitcher.writeConfig("showName", false)
uswitcher.writeConfig("showSett", false)
uswitcher.writeConfig("showTechnicalInfo", true)

// *****************************************************
// Create Left Side Panel
// *****************************************************

var leftpanel = new plasma.Panel
leftpanel.location = "left"
leftpanel.height = gridUnit * 2
leftpanel.offset=panel.height

// Add widgets to the left side panel

// Add Application Dashboard to Left Side Panel
// Add default shortcut to the kickerdash menu
var menu = leftpanel.addWidget("org.kde.plasma.kickerdash")
menu.currentConfigGroup = ["Shortcuts"]
menu.writeConfig("global", "Alt+F1")
menu.currentConfigGroup = ["General"]
menu.writeConfig("favoriteApps", [
    'firefox.desktop',
    'org.kde.konsole.desktop',
    'org.kde.dolphin.desktop',
    'systemsettings.desktop',
    'org.kde.ksysguard.desktop',
].join(','))
menu.writeConfig("favoriteSystemActions", [
    'logout',
    'reboot',
    'shutdown',
].join(','))

// Add icons-only Task Manager to Left Side Panel
var tasks = leftpanel.addWidget("org.kde.plasma.icontasks")
tasks.currentConfigGroup = ["General"]
tasks.writeConfig("groupingStrategy", "0")
tasks.writeConfig("maxStripes", "1")
tasks.writeConfig("showOnlyCurrentActivity", "true")
tasks.writeConfig("showOnlyCurrentDesktop", "true")
tasks.writeConfig("sortingStrategy", "1")
tasks.writeConfig("highlightWindows", true)
tasks.writeConfig("showOnlyCurrentScreen", true)
tasks.writeConfig("launchers", [
    'file:///usr/share/applications/firefox.desktop?wmClass=firefox',
    'file:///usr/share/applications/google-chrome.desktop?wmClass=google-chrome',
    'file:///usr/share/applications/org.kde.konsole.desktop?wmClass=konsole',
    'file:///usr/share/applications/org.kde.dolphin.desktop?wmClass=dolphin',
    'file:///usr/share/applications/org.kde.kate.desktop?wmClass=kate',
    'file:///usr/share/applications/systemsettings.desktop?wmClass=systemsettings',
].join(','))

// Add Present Windows Button to Left Side Panel
//     ...   https://store.kde.org/p/1181039/
//     ...   added kns://plasmoids.knsrc/api.kde-look.org/1181039 to X-KPackage-Dependencies= in metadata.desktop
// Toggle desktop grid
var windows = leftpanel.addWidget("com.github.zren.presentwindows")
windows.currentConfigGroup = ["Configuration", "General"]
windows.writeConfig("clickCommand","ShowDesktopGrid")

// Add Trashcan to Left Side Panel
leftpanel.addWidget("org.kde.plasma.trash")

activity.currentConfigGroup = ["General"]
activity.writeConfig("immutability", 2)
