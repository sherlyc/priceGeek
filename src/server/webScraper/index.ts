import aws from 'aws-sdk';
import axios from 'axios';
import cheerio from 'cheerio';

const docClient = new aws.DynamoDB.DocumentClient({ region: 'ap-southeast-2'});

var params = {
    TableName: 'ProductScraper-dev'
};

async function listItems() {
    var params = {
        TableName: 'ProductScraper-dev'
    }

    try {
        const data = await docClient.scan(params).promise();
        console.log('list Items', data);
        return data;
    } catch (err) {
        return err;
    }
}

export const handler = async () => {
    const data = await listItems();
    console.log("###################")
    console.log('data:', data);
    const url = 'https://www.mightyape.co.nz/product/ps4-slim-1tb-value-bundle-ps4/25921903';
    const response = await axios.get(url);
    const $ = cheerio.load(response.data);
    const pricing = $('div.page.listing div.pricing-stock span.price').text().trim();
    console.info('price:', pricing);
};


