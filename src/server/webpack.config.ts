import {Configuration} from "webpack";
import { readdirSync } from "fs";
import {join} from "path";

const serverSrc = "./src/server/";

const getDirectories = (serverPath: string) =>
    readdirSync(serverPath, { withFileTypes: true })
        .filter(dirent => dirent.isDirectory())
        .map(dirent => {
            return {[dirent.name]:`${serverSrc}${dirent.name}/index.ts`}
        })

const entries = Object.assign({}, ...getDirectories(serverSrc));
console.log(join(__dirname, "../../dist/server"))

export default {
    mode: "production",
    entry: entries,
    optimization: {minimize: false},
    output: {
        path: join(__dirname, "../../dist/server"),
        filename: "[name]/index.js",
        libraryTarget: "commonjs"
    },
    resolve: {
        extensions: ['.ts', '.js']
    },
    module : {
        rules: [{
            test:  /\.tsx?$/, use: 'ts-loader'
        }]
    },
    devServer: {
        port: 3000
    }
} as Configuration;