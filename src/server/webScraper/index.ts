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
    if(data){
        const url = data[0].url;
        const response = await axios.get(url);
        const $ = cheerio.load(response.data);
        const pricing = $('div.page.listing div.pricing-stock span.price').text().trim();
        console.info('price:', pricing);
        return pricing;
    }
    console.log('no data, exiting')
};


