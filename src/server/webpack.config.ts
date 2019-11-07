import {Configuration} from "webpack";
import { readdirSync } from "fs";

const serverSrc = "./src/server/";

const getDirectories = (serverPath: string) =>
    readdirSync(serverPath, { withFileTypes: true })
        .filter(dirent => dirent.isDirectory())
        .map(dirent => {
            return {[dirent.name]:`${serverSrc}${dirent.name}/index.ts`}
        })

const entries = Object.assign({}, ...getDirectories(serverSrc));

export default {
    mode: "production",
    entry: entries,
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