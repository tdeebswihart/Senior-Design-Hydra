Senior-Design-Hydra
===================
All curate files have been paved over, the only files here are now the conversion scripts

###First Time configuration
- `cd batch_converter`
- `bundle install`
- (put instructions for pulling down hydra-jetty here)

###Running the application
- `ruby driver.rb`

###What is `config.json`?
- [JSON](https://en.wikipedia.org/wiki/JSON) formatted configuration file. It is of the structure:
```javascript
{
	"prefix|namespace|xpath_action": {
		"tag": "model_attribute_name",
		"tag2": "model_attribute_name2"
	},
	"@xlink|http://www.w3.org/1999/xlink": { 
		"href": "items",
	}
}
```

These would evaluate to (in the conversion code) an [XPATH](https://en.wikipedia.org/wiki/Xpath) of:
- `.//prefix:tag/text()`: grab the text from elements that match the search path `.//prefix:tag` and place the value in MODEL.model_attribute_name
- `.//prefix:tag2/text()`: grab the text from elements that match the search path `.//prefix:tag2` and place the value in MODEL.model_attribute_name2
- `.//@xlink:href`: grab the value of the href element of elements that match the search path and place the values in the list MODEL.items

The code doing this can be found in `collection_builder.rb` lines 29-33

Note: attribute names ending in an 's' denote lists: so `"some_tag": "files"` would put everything in the list MODEL.files