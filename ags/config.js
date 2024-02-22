//@ts-check
import App from 'resource:///com/github/Aylur/ags/app.js'
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js'

const src_folder = App.configDir + '/ts/';

const outdir = App.configDir + '/build/';

const paths = (await execAsync(['find', src_folder, '-type', 'f'])).split('\n');

console.log(`building ags config from ${src_folder}`);

console.log(`building : \n ${paths.join('\n')}`);

await execAsync([
  'bun', 'build', ...paths,
  '--root', src_folder,
  '--outdir', outdir,
  '--external', '*',
]).catch(e => console.error(e));

const main = await import(`file://${outdir}/ts/main.js`)

export default main.default
