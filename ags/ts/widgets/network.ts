import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Network from 'resource:///com/github/Aylur/ags/service/network.js';

const WifiIndicator = () => Widget.Box({
  spacing: 10,
  children: [
    Widget.Icon({
      icon: Network.wifi.bind('icon_name'),
    }),
    Widget.Label({
      label: Network.wifi.bind('ssid'),
    }),
  ],
})

const WiredIndicator = () => Widget.Icon({
  icon: Network.wired.bind('icon_name'),
})

export default Widget.Stack({
  items: [
    ['wifi', WifiIndicator()],
    ['wired', WiredIndicator()],
  ],
  shown: Network.bind('primary').transform(p => p || 'wifi'),
})
