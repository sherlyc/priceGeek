import {Browser, launch, Page} from 'puppeteer';

jest.setTimeout(30000);

describe('e2e test', () => {
    let browser: Browser;
    let page: Page;

    beforeEach(async () => {
        page = await browser.newPage();
    });
    beforeAll(async () => {
        browser = await launch();

    });
    describe('dev homepage', () => {
        const devHomepage = 'https://d2mc8xylnixdyv.cloudfront.net';

        it('should display Hello world!', async () => {
            await page.goto(devHomepage);
            await page.waitForSelector('.content');
            const textContent = await page.evaluate(() => document.querySelector('.content')!.textContent);

            await expect(textContent).toMatch('Welcome to PriceGeek!')
        });
    });

    describe('prod homepage', () => {
        const prodHomepage = 'https://d13bcdzaghwlha.cloudfront.net';

        it('should display Hello world!', async () => {
            await page.goto(prodHomepage);
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