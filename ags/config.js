//@ts-check
import App from 'resource:///com/github/Aylur/ags/app.js'
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js'

const src_folder = App.configDir + '/ts/';

const outdir = '/tmp/ags/js';

const paths = (await execAsync(['find', src_folder, '-type', 'f'])).split('\n');

console.log(`building ags config from ${src_folder}`);

await execAsync([
  'bun', 'build', ...paths,
  '--outdir', outdir,
  '--external', '*',
]).catch(e => console.error('fiwheoifhw', e));


const main = await import(`file://${outdir}/main.js`)

export default main.default
