'use strict';
import restify from 'restify';
import util from 'util';
var server = restify.createServer({name: 'Foo-Service', version: '0.0.1'});
server.use(restify.plugins.authorizationParser());
server.use(restify.plugins.queryParser());
server.use(restify.plugins.bodyParser({mapParams: true}));

function inspect_request(req) {
    var data = [
        '======= HEADERS =======',
        req.headers, 
        '======= AUTHORIZATION =======',
        req.authorization, 
        '======= REQUEST PARAMS (post) =======',
        req.params,
        '======= REQUEST QUERY (get) =======',
        req.query
    ];
    console.log(util.inspect(data));
}

server.get('/get-foo', async (req, res, next) => {
    inspect_request(req);
    res.send({});
    next(false);
});
server.post('/post-foo', async (req, res, next) => {
    inspect_request(req);
    res.send({});
    next(false);
});
server.del('/del-foo', async (req, res, next) => {
    inspect_request(req);
    res.send({});
    next(false);
});
server.put('/put-foo', async (req, res, next) => {
    inspect_request(req);
    res.send({});
    next(false);
});

server.listen(process.env.PORT, 'localhost');