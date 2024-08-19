import express from "express";

const app = express();

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.get('/jokes', (req, res) => {
     const jokes = [
            {
                id : 1,
                title : 'Why did the chicken cross the road?',
                punchline : 'To get to the other side!'
            },
            {
                id : 2,
                title : 'Why did the cow cross the road?',
                punchline : 'To get to the other side!'
            }
        ];
    res.send(jokes);
});

const port = process.env.PORT || 3000;

app.listen(port, () => {
    console.log(`Server listening on port http://localhost:${port}`);
});