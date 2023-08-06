import { $, $stream } from "./zx";

interface Workspace {
  id: number;
  name: string;
  windows: number;
  lastwindowtitle: string;
}

interface Monitor {
  id: number;
  name: string;
  focused: boolean;
  activeWorkspace: { id: number; name: string };
}

async function get_worspaces() {
  let workspaces: Workspace[] = [];

  // default display
  fill_workspaces(workspaces);
  console.log(JSON.stringify({ workspaces, active_workspace_id: 1 }));
  //

  let { stdout } = await $stream`socat -u \
   UNIX-CONNECT:/tmp/hypr/${process.env
     .HYPRLAND_INSTANCE_SIGNATURE!}/.socket2.sock -`;

  for await (let _ of stdout as ReadableStream<Buffer>) {
    workspaces = JSON.parse(await $`hyprctl workspaces -j`);
    fill_workspaces(workspaces);

    const monitors: Monitor[] = JSON.parse(await $`hyprctl monitors -j`);
    const active_workspace_id = monitors.find((monitor) => monitor.focused)
      ?.activeWorkspace.id;

    console.log(JSON.stringify({ workspaces, active_workspace_id }));
  }
}

function fill_workspaces(workspaces: Workspace[]) {
  for (let i = 1; i <= 10; i++) {
    if (!workspaces.find((e) => e.id === i)) {
      workspaces.push({
        id: i,
        name: `workspace ${i}`,
        windows: 0,
        lastwindowtitle: "",
      });
    }
  }
  workspaces.sort((workspace1, workspace2) => workspace1.id - workspace2.id);
}

function help() {
  console.log(
    process.argv[1].substring(process.argv[1].lastIndexOf("/") + 1),
    "[status]"
  );
}

type Parameter = "status";
switch (process.argv[2] as Parameter) {
  case "status":
    await get_worspaces();
    break;
  default:
    help();
    break;
}
