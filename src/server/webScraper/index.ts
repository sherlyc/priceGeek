import aws from 'aws-sdk';
import axios from 'axios';
import cheerio from 'cheerio';

const docClient = new aws.DynamoDB.DocumentClient({ region: 'ap-southeast-2'});

const params = {
    TableName: 'ProductScraper-dev'
};

async function listItems() {
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
    if(data) {
        const { Url, VendorId, ProductId } = data.Items[0];
        const response = await axios.get(Url);
        const $ = cheerio.load(response.data);
        const pricing = $('div.pricing-stock div.price span.price').text().trim();
        console.info('price:', pricing, 'ProductId:', ProductId, 'VendorId', VendorId);
        return pricing;
    }
    console.log('no data, exiting')
};


