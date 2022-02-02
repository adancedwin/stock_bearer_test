# The task
We have two entities Stock and Bearer. The app needs to implement some API functionality.

The following needs to be accessible through API:
- Create a new Stock with unique name and with it's Bearer
- Update stock to a new unique name and Bearer property
- List all stocks with Bearer info
- Delete a stock (soft delete)

# Setup
### 1. Versions
Make sure you have the latest stable ruby version which is currently for this project - 3.0.2 version.

As a persistent storage the project uses Postgres database, make sure you have version 9.3 or later.

### 2. Bundle up
Go to the project's directory in your command line `bundle install` or simply `bundle`.

# Launch the project
### 1. Database setup
Find database.yml.example and configure it to your own Postgres database.

Then run:
```
bundle exec rails db:create && bundle exec rails db:migrate
```

### 2. Launch the app
Launch Rails app:
```
bundle exec rails s
```


Run unit tests:
```
bundle exec rspec
```

# How to use API
To send requests to API you can use Postman's desktop app. The payload should be of JSON format.

The default address would start with `http://localhost:3000/`

##**API endpoints**

### 1. Creating a new Stock
**Endpoint info**

Method | Path
------------ | -------------
POST | api/v1/stocks

**Parameters**

Parameter | Type | Required?
------------ | ------------- | -------------
stock_name | string | yes
bearer_name | string | yes

JSON body example:
```
{
  "stock_name": "stock name",
  "bearer_name": "bearer name"
}
```

### 2. Updating a Stock
**Endpoint info**

Method | Path
------------ | -------------
POST | api/v1/stocks/:stock_name

**Parameters**

Parameter | Type | Required?
------------ | ------------- | -------------
stock_name | string | yes (included in a path)
new_stock_name | string | yes
bearer_name | string | yes

JSON body example:
```
{
  "new_stock_name": "new unique stock name",
  "bearer_name": "bearer name"
}
```

### 3. Listing all Stocks
**Endpoint info**

Method | Path
------------ | -------------
GET | api/v1/stocks

### 4. Deleting a Stock
**Endpoint info**

Method | Path
------------ | -------------
POST | api/v1/stocks/:stock_name/delete

**Parameters**

Parameter | Type | Required?
------------ | ------------- | -------------
stock_name | string | yes (included in a path)
