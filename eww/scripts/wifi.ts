import { $, $stream } from "./zx";

const DEVICE = "wlan0";

enum ConnectionStatus {
  FULL = 4,
  OFFLINE = 1,
}

function get_icon(status: ConnectionStatus) {
  switch (status) {
    case ConnectionStatus.FULL:
      return "󰤨";
    case ConnectionStatus.OFFLINE:
      return "󰤩 ";
    default:
      return "󰤩 ";
  }
}

let { stdout } = await $stream`nmcli monitor`;

for await (let _ of stdout) {
  const device_data =
    await $`nmcli -f GENERAL.CONNECTION,GENERAL.IP4-CONNECTIVITY,IP4.ADDRESS dev show ${DEVICE}`;
  /// extract the connection name formatted : GENERAL.CONNECTION:                     #home
  const connection_name = (
    device_data.match(/GENERAL\.CONNECTION:.*/)?.[0] ?? "none"
  ).replace(/GENERAL\.CONNECTION: */, "");

  /// extract the IPV4
  const ipv4 = (
    device_data.match(/IP4\.ADDRESS\[1\]:.*/)?.[0] ?? "none"
  ).replace(/IP4\.ADDRESS\[1\]: */, "");

  /// extract the status
  const status: ConnectionStatus = parseInt(
    (device_data.match(/GENERAL\.IP4-CONNECTIVITY:.*/)?.[0] ?? "1").replace(
      /GENERAL\.IP4-CONNECTIVITY: */,
      ""
    )
  );
  console.log(
    JSON.stringify({ status, ipv4, connection_name, icon: get_icon(status) })
  );
}
