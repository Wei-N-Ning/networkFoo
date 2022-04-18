# http crash course

source: youtube | HTTP Crash Course & Exploration

## developer-tool in Chrome

click network to see the data downloaded;

click each item to see its content and type;

can also see the header and other important info;

## foo-server workshop

### set up foo-server

```bash
cd ./foo_server
# repopulate node_modules dir
npm install
# there can be outdated packages (vuln) this fix them
npm audit fix
```

port number is `43333`

### set up postman

### exercise each HTTP Method

get, get with parameters;

post, post with body, post with body that is of certain type,
post with form data;

update the foo-server handler to return status code based on
certain parameter value;

put data and see `<id>` is updated (just send the id back in
the response)

delete data and see `<id>` is deleted (just send the id back in
the response)

test `x-auth-token` and in the handler, send back 400 if `x-auth-token`
is unset; 401 if token does not pass authentication; 200 if all good
