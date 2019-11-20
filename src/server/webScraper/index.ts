import cheerio from 'cheerio'
import axios from 'axios'

export const handler = async () => {
    const url = 'https://www.mightyape.co.nz/product/ps4-slim-1tb-value-bundle-ps4/25921903';
    const response = await axios.get(url);
    const $ = cheerio.load(response.data);
    const pricing = $('div.page.listing div.pricing-stock span.price').text().trim();
    console.info(pricing);
};


