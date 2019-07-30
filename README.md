# DataCollector

DataCollector is ruby script written for data collection from power plants witch communicate through various of communication protocols. DataCollector supporting ModbusRTUviaTCP, ModbusTCP, Aurora protocol.

## Prepare

_config.json_ 
```
{
  "API_URL" : "url_to_api",
  "email" : "login@email.com",
  "pass" : "loginPassword"
}
```

## Installation


```
git clone git@github.com:ErikDvorcak/dataCollector.git
crontab -e  (and append to crontab next line where {path} is path to repository)
* * * * * cd {path}/dataCollector/lib/ && ruby dataCollector.rb
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/erikdvorcak/dataCollector. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

