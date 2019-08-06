import {Browser, launch, Page} from 'puppeteer';
import config from './config.json';

jest.setTimeout(30000);

const envConfig : { [key: string]: any } = config;

describe('e2e test', () => {
    let browser: Browser;
    let page: Page;
    let env = process.env.ENV || 'dev';

    beforeEach(async () => {
        page = await browser.newPage();
    });
    beforeAll(async () => {
        browser = await launch({args: ['--no-sandbox', '--disable-setuid-sandbox']});

    });
    describe('homepage', () => {
        const homePage = envConfig[env].testUrl;
        console.log('opening homepage in environment: ', env);

        it('should display Welcome to PriceGeek!', async () => {
            await page.goto(homePage);
            await page.waitForSelector('.content');
            const textContent = await page.evaluate(() => document.querySelector('.content')!.textContent);

            await expect(textContent).toMatch('Welcome to PriceGeek!')
        });
    });

    afterEach(async() => {
        await page.close();
    });

    afterAll(async() => {
        await browser.close();
    });
});