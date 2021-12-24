# Gluegun Starter - CLI

A CLI Starter for your next [Gluegun](https://infinitered.github.io/gluegun/#/) CLI project.

![Gluegun Menu Demo](assets/demo.gif)

---

## Initial Setup

<!--
Via lenne.Tech CLI:
-->

<!--
```shell
$ npm install -g @lenne.tech/cli
$ lt cli create <CLI_NAME>
```
-->

### GitHub

```shell
git clone https://github.com/TheoryLabs/GluegunStarter.git <CLI_NAME>
cd <CLI_NAME>
npm i
npm run rename <CLI_NAME>
```

### Manual

1. Download Starter: https://github.com/TheoryLabs/GluegunStarter/archive/main.zip
    - `wget https://github.com/TheoryLabs/GluegunStarter/archive/main.zip`
2. Unpack ZIP File (`main.zip`):
    - `unzip main.zip`
3. Rename Unzipped folder:
    - `mv GluegunStarter-main <CLI_NAME>`
4. Remove downloaded ZIP file:
    - `rm main.zip`
5. Navigate into folder:
    - `cd <CLI_NAME>`
6. Run Package Manager installation script: 
    - `npm i`
7. Run script to rename the project as your own:
    - `npm run rename <CLI_NAME>`

---



<!--
## Customizing your CLI

Check out the documentation at https://github.com/infinitered/gluegun/tree/master/docs.

## Publishing to NPM

To package your CLI up for NPM, do this:

```shell
$ npm login
$ npm whoami
$ npm lint
$ npm test
(if typescript, run `npm run build` here)
$ npm publish
(if you are publish a plublic package for the first time: npm publish --access public)
```

# License

MIT - see LICENSE
-->