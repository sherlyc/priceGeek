import aws from 'aws-sdk';
import axios from 'axios';
import cheerio from 'cheerio';

const docClient = new aws.DynamoDB.DocumentClient({ region: 'ap-southeast-2'});
const env = process.env.environment;

async function getItem(productId: string, vendorId: string) {
    const params = {
        TableName: `ProductScraper-${env}`,
        Key: {
            "ProductId": productId,
            "VendorId": vendorId
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

async function putItem(productId: string, vendorId: string, price: string) {
    const params = {
        TableName: `ProductScraper-${env}`,
        Item: {
            "ProductId_VendorId": `${productId}_${vendorId}`,
            "Timestamp": new Date().toISOString(),
            "Price": price
        }
    };

    try {
        const data = await docClient.put(params).promise();
        console.log('put item', data);
        return data;
    } catch (err) {
        console.error("Unable to put item. Error JSON:", JSON.stringify(err, null, 2));
        return err;
    }
}

export const handler = async () => {
    const productId = "1001";
    const vendorId = "1";
    const data = await getItem(productId, vendorId);

    if(data) {
        const response = await axios.get(data.Item.Url);
        const $ = cheerio.load(response.data);
        const pricing = $('div.pricing-stock div.price span.price').text().trim();
        console.info('item', JSON.stringify(data, null, 2));
        await putItem(productId, vendorId, pricing);

        return pricing;
    }
    console.log('no data, exiting')
};


