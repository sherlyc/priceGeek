import aws from 'aws-sdk';
import axios from 'axios';
import cheerio from 'cheerio';

const docClient = new aws.DynamoDB.DocumentClient({ region: 'ap-southeast-2'});

async function getItem() {
    const params = {
        TableName: 'ProductScraper-dev',
        Key: {
            "ProductId": {
                N: "1001"
            },
            "VendorId": {
                N: "1"
            }
        }
    };

    try {
        const data = await docClient.get(params).promise();
        console.log('get item', data);
        return data;
    } catch (err) {
        return err;
    }
}

export const handler = async () => {
    const data = await getItem();
    if(data) {
        const item = data.item;
        // const url = item.Url.S;
        // const vendor = item.VendorId.N;
        // const product = item.ProductId.N;
        const response = await axios.get("https://www.mightyape.co.nz/product/ps4-slim-1tb-value-bundle/25921903");
        const $ = cheerio.load(response.data);
        const pricing = $('div.pricing-stock div.price span.price').text().trim();
        console.info('item', item);
        return pricing;
    }
    console.log('no data, exiting')
};


