import express from 'express';
import IndexController from './controllers/index.js';

const app = express();
const port = 3000;

app.get('/', (new IndexController()).index);

app.listen(port, () => {
    console.log(`Viewer listening on http://localhost:${port}`)
});



