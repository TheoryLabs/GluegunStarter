import * as config from '../package.json'
const { system, filesystem } = require('gluegun')

const src = filesystem.path(__dirname, '..')

const cli = async cmd =>
  system.run('node ' + filesystem.path(src, 'bin', 'cli-starter') + ` ${cmd}`)

test('outputs version', async () => {
  const output = await cli('--version')
  expect(output).toContain(config.version)
})

test('outputs help', async () => {
  const output = await cli('--help')
  expect(output).toContain(config.version)
})
