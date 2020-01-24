import aws from 'aws-sdk';
import axios from 'axios';
import cheerio from 'cheerio';

const docClient = new aws.DynamoDB.DocumentClient({ region: 'ap-southeast-2'});
const env = process.env.environment;

async function getItem() {
    const params = {
        TableName: `ProductScraper-${env}`,
        Key: {
            "ProductId": 1001,
            "VendorId": 1
        }
    };

    try {
        const data = await docClient.get(params).promise();
        console.log('get item', data);
        return data;
    } catch (err) {
        console.error("Unable to read item. Error JSON:", JSON.stringify(err, null, 2));
        return err;
    }
}

export const handler = async () => {
    const data = await getItem();
    if(data) {
        console.log(data.Item.ProductId)
        const response = await axios.get(data.Item.Url);
        const $ = cheerio.load(response.data);
        const pricing = $('div.pricing-stock div.price span.price').text().trim();
        console.info('item', JSON.stringify(data, null, 2));
        return pricing;
    }
    console.log('no data, exiting')
};


